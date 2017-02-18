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
    user_protocol = UsersProtocol.where('protocol_id = ? and user_id = ?', params[:id], current_user.id).select('id').first
    ieees = Ieee.where('protocol_id = ?', params[:id]).select('id')
    acms = Acm.where('protocol_id = ?', params[:id]).select('id')
    scopus = Scopu.where('protocol_id = ?', params[:id]).select('id')
    springers = Springer.where('protocol_id = ?', params[:id]).select('id')
    scidirs = Scidir.where('protocol_id = ?', params[:id]).select('id')
    @ieee = IeeesUsersProtocol.where('ieee_id in (?) AND users_protocol_id = ? AND included IS NULL', ieees, user_protocol.id)
    @acm = AcmsUsersProtocol.where('acm_id in (?) AND users_protocol_id = ? AND included IS NULL', acms, user_protocol.id)
    @scopus = ScopusUsersProtocol.where('scopu_id in (?) AND users_protocol_id = ? AND included IS NULL', scopus, user_protocol.id)
    @springer = SpringersUsersProtocol.where('springer_id in (?) AND users_protocol_id = ? AND included IS NULL', springers, user_protocol.id)
    @scidir = ScidirsUsersProtocol.where('scidir_id in (?) AND users_protocol_id = ? AND included IS NULL', scidirs, user_protocol.id)
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
      format.js {  }
    end
  end

  def distribute
    hash = Hash.new()

    params[:distribution].each do | user_range |
      userProtocolId = user_range[:user_id].to_i
      range = user_range[:range].to_i
      hash[userProtocolId] = range
      if @protocol.nil?
        @protocol = UsersProtocol.find(userProtocolId).protocol
      end
    end
    byebug
    if !hash.empty?
      IeeesUsersProtocol.randomize_studies(hash, @protocol) if @protocol.ieee?

      ScidirsUsersProtocol.randomize_studies(hash, @protocol) if @protocol.science_direct?

      AcmsUsersProtocol.randomize_studies(hash, @protocol) if @protocol.acm?

      SpringersUsersProtocol.randomize_studies(hash, @protocol) if @protocol.springer?

      ScopusUsersProtocol.randomize_studies(hash, @protocol) if @protocol.scopus?

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
