class ScidirsUsersProtocolsController < ApplicationController

  def show
    studies = Scidir.where(protocol_id: params[:id])
    scidirs_id = ScidirsUsersProtocol.where(users_protocol_id: UsersProtocol.where(protocol_id: params[:id].to_i, user_id: current_user.id).first).select('scidir_id')
    @scidirs = studies.where(id: scidirs_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @scidir = Scidir.find(params[:id])

    @included = Included.new
    @included.title = @scidir.title
    @included.author = @scidir.author
    @included.pubtitle = @scidir.pubtitle
    @included.protocol_id = @scidir.protocol_id
    @included.link = @scidir.link
    @included.name_database = 'scidir'
    @included.included = 0
    @included.save!

    @scidir.destroy

    redirect_to :back
  end

  def unselect
    @scidir = Scidir.find(params[:id])
    @scidir.destroy

    redirect_to :back
  end
end
