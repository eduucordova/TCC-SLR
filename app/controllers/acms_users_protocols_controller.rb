class AcmsUsersProtocolsController < ApplicationController

  def show
    studies = Acm.where(protocol_id: params[:id])
    acms_id = AcmsUsersProtocol.where(users_protocol_id: UsersProtocol.where(protocol_id: params[:id].to_i, user_id: current_user.id).first).select('acm_id')
    @acms = studies.where(id: acms_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @acm = Acm.find(params[:id])

    @included = Included.new
    @included.title = @acm.title
    @included.author = @acm.author
    @included.pubtitle = @acm.pubtitle
    @included.protocol_id = @acm.protocol_id
    @included.link = @acm.link
    @included.name_database = 'acm'
    @included.included = 0
    @included.save!

    @acm.destroy

    redirect_to :back
  end

  def unselect
    @acm = Acm.find(params[:id])
    @acm.destroy

    redirect_to :back
  end
end
