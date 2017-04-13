class ProtocolsController < ApplicationController
  before_action :set_protocol, only: [:show, :edit, :update, :destroy]

  # GET /protocols
  # GET /protocols.json
  def index
    if !current_user.nil?
      @users_protocols = current_user.users_protocols.includes(:protocol).order(created_at: :desc).each do |user_protocol|
        puts user_protocol.ref_exists = reference_exist_by_id(user_protocol.protocol.id)
      end
    end
  end

  # GET /protocols/1
  # GET /protocols/1.json
  def show
    @role = @protocol.users_protocols.select(:role_id).where(user: current_user).first.role_id
    @users_protocols = @protocol.users_protocols.includes(:user).each do |user_protocol|
      puts user_protocol.role.name
      puts user_protocol.user.username
      puts user_protocol.ref_exists
    end

    session[:protocol_id] = params[:id].to_i
  end

  # GET /protocols/new
  def new
    @protocol = current_user.protocols.build

    1.times { @protocol.terms.build }
    1.times { @protocol.users_protocols.build({ user_id: current_user.id, role_id: 1 }) }

    @protocol.ieee = true
    @protocol.science_direct = true
    @protocol.acm = true
    @protocol.springer = true
    @protocol.from = 2007
    @protocol.to = 2017
  end

  # GET /protocols/1/edit
  def edit
  end

  # POST /protocols
  # POST /protocols.json
  def create
    @protocol = current_user.protocols.build(protocol_params)

    attributes = protocol_params[:terms_attributes]

    @protocol.query = @protocol.generate_string(attributes)

    respond_to do |format|
      if @protocol.save
        format.html { redirect_to @protocol, notice: 'Protocol was successfully created.' }
        format.json { render :show, status: :created, location: @protocol }
      else
        format.html { render :new }
        format.json { render json: @protocol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /protocols/1
  # PATCH/PUT /protocols/1.json
  def update

    attributes = protocol_params[:terms_attributes]

    @protocol.query = @protocol.generate_string(attributes)
    # Como a base Scopus não será mais utilizada, garantir que os
    # protocolos anteriores à atualização não terão mais esta referência
    @protocol.scopus = false
    respond_to do |format|
      if @protocol.update(protocol_params)
        format.html { redirect_to @protocol, notice: 'Protocol was successfully updated.' }
        format.json { render :show, status: :ok, location: @protocol }
      else
        format.html { render :edit }
        format.json { render json: @protocol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /protocols/1
  # DELETE /protocols/1.json
  def destroy
    @protocol.destroy
    respond_to do |format|
      format.html { redirect_to protocols_url, notice: 'Protocol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @protocol = Protocol.find(params[:id])
    @ref_protocol = reference_exist
  end

  def do_search
    @protocol = Protocol.find(params[:id])

    @protocol.clean_bases(params[:id])

    from = params[:protocol][:from]
    to = params[:protocol][:to]
    query = params[:protocol][:query]
    protocol_id = params[:id]
    max_results = params[:protocol][:results_returned]

    if @protocol.ieee
      @ieee = Ieee.new
      @ieee = @ieee.search(query, protocol_id, max_results, from, to)
    end

    if @protocol.science_direct
      @scidir = Scidir.new
      @scidir = @scidir.search(query, protocol_id, max_results, from, to)
    end

    if @protocol.acm
      @acm = Acm.new
      @acm = @acm.search(query, protocol_id, max_results, from, to)
    end

    if @protocol.springer
      @springer = Springer.new
      @springer = @springer.search(query, protocol_id, max_results, from, to)
    end

    redirect_to reference_url(protocol_id)
  end

  def selected
    @protocol = Protocol.find(params[:id])
    @user_protocol = UsersProtocol.where(protocol_id: params[:id], user_id: current_user.id).first

    @selected_acm = []
    @selected_ieee = []
    @selected_scidir = []
    @selected_springer = []

    if @protocol.ieee
      ieees_id = IeeesUsersProtocol.where(users_protocol_id: @user_protocol, pre_selected: true, maybe: nil, included: nil).select(:ieee_id)
      @selected = Ieee.where(id: ieees_id)

      @selected.each { |ieee|
        @selected_ieee.push(ieee)
      }
    end

    if @protocol.science_direct
      scidirs_id = ScidirsUsersProtocol.where(users_protocol_id: @user_protocol, pre_selected: true, maybe: nil, included: nil).select(:scidir_id)
      @selected = Scidir.where(id: scidirs_id)

      @selected.each { |scidir|
        @selected_scidir.push(scidir)
      }
    end

    if @protocol.acm
      acms_id = AcmsUsersProtocol.where(users_protocol_id: @user_protocol, pre_selected: true, maybe: nil, included: nil).select(:acm_id)
      @selected = Acm.where(id: acms_id)

      @selected.each { |acm|
        @selected_acm.push(acm)
      }
    end

    if @protocol.springer
      springers_id = SpringersUsersProtocol.where(users_protocol_id: @user_protocol, pre_selected: true, maybe: nil, included: nil).select(:springer_id)
      @selected = Springer.where(id: springers_id)

      @selected.each { |springer|
        @selected_springer.push(springer)
      }
    end

    @empty_ieee = (@selected_ieee.empty?) ? true : false
    @empty_scidir = (@selected_scidir.empty?) ? true : false
    @empty_acm = (@selected_acm.empty?) ? true : false
    @empty_springer = (@selected_springer.empty?) ? true : false

    @ref_protocol = reference_exist
  end

  def included
    @protocol = Protocol.find(params[:id])

    @included_ieee = []
    @included_scidir = []
    @included_acm = []
    @included_springer = []

    if @protocol.ieee
      @included = Included.where("protocol_id = ? AND included = 1 AND name_database = 'ieee'", params[:id])

      @included.each { |ieee|
        @included_ieee.push(ieee)
      }

      @count_ieee = @included_ieee.count.to_s
    end

    if @protocol.science_direct
      @included = Included.where("protocol_id = ? AND included = 1 AND name_database = 'scidir'", params[:id])

      @included.each { |scidir|
        @included_scidir.push(scidir)
      }

      @count_scidir = @included_scidir.count.to_s
    end

    if @protocol.acm
      @included = Included.where("protocol_id = ? AND included = 1 AND name_database = 'acm'", params[:id])

      @included.each { |acm|
        @included_acm.push(acm)
      }

      @count_acm = @included_acm.count.to_s
    end

    if @protocol.springer
      @included = Included.where("protocol_id = ? AND included = 1 AND name_database = 'springer'", params[:id])

      @included.each { |springer|
        @included_springer.push(springer)
      }

      @count_springer = @included_springer.count.to_s
    end

    @empty_ieee = (@included_ieee.empty?) ? true : false
    @empty_scidir = (@included_scidir.empty?) ? true : false
    @empty_acm = (@included_acm.empty?) ? true : false
    @empty_springer = (@included_springer.empty?) ? true : false

    @ref_protocol = reference_exist

    @includeds = Included.where("included = 1 AND protocol_id = ?", params[:id])

    respond_to do |format|
      format.html
      format.xls
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_protocol
    @protocol = Protocol.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def protocol_params
    params.require(:protocol).permit(:id, :title, :background, :research_question, :strategy, :criteria, :from, :to, :results_returned,
                                     :ieee, :acm, :springer, :science_direct, :google_scholar, :scopus, :quality,
                                     :users_protocols_attributes => [:id, :user_id, :role_id, :_destroy],
                                     :terms_attributes => [:id, :termo, :sinonimo, :sinonimo2, :sinonimo3, :traducao, :traducao2, :traducao3, :_destroy])
  end

  # Verifica se alguma busca já foi realizada para aquele protocolo
  def reference_exist
    Reference.find_by_protocol_id(params[:id])
  end
  def reference_exist_by_id(id)
    Reference.find_by_protocol_id(id)
  end
end
