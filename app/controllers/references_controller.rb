class ReferencesController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /references
  # GET /references.json
  def index
    @references = Reference.all
  end

  # GET /references/1
  # GET /references/1.json
  def show
    @users_protocols_range = Protocol.find(params[:id]).users_protocols.includes(:user).each do |user_protocol|
      puts user_protocol.id
      puts user_protocol.role.name
      puts user_protocol.user.username
    end

    @reference = Reference.where('protocol_id = ?', params[:id])
  end

  # GET /references/new
  def new
    @reference = Reference.new
  end

  # GET /references/1/edit
  def edit
  end

  def distribute_studies
    @users_protocols_range = Protocol.find(params[:id]).users_protocols.includes(:user).each do |user_protocol|
      puts user_protocol.id
      puts user_protocol.role.name
      puts user_protocol.user.username
    end
    respond_to do |format|
      format.html { render :partial => 'distribute_studies' }
      format.json
    end
  end

  def distribute
    hash = Hash.new()
    # Ugliest way to parse data from server
    params.first[1].first.first.split(',').each do |user_range|
      if user_range.include? 'user_id'
        @userProtocolId = user_range.scan(/\d+/).first
        @range = nil
        if @protocol.nil?
          @protocol = UsersProtocol.find(@userProtocolId).protocol
        end
      else
        @range = user_range.scan(/\d+/).first.to_i
        byebug
        hash[@userProtocolId] = @range
      end

      ScopusUsersProtocol.randomize_studies(hash, @protocol) if @protocol.scopus?

      if !hash.empty? && false
        IeeesUsersProtocol.randomize_studies(@userProtocolId, @range) if @protocol.ieee?

        ScidirUsersProtocol.randomize_studies(@userProtocolId, @range) if @protocol.science_direct?

        ScopusUsersProtocol.randomize_studies(@userProtocolId, @range) if @protocol.scopus?

        AcmUsersProtocol.randomize_studies(@userProtocolId, @range) if @protocol.acm?

        SpringerUsersProtocol.randomize_studies(@userProtocolId, @range) if @protocol.springer?
      end
    end

    redirect_to :back
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reference
    @reference = Reference.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reference_params
    params.require(:reference).permit(:query)
  end

end
