class ScopusUsersProtocolsController < ApplicationController

  def show
    studies = Scopu.where(protocol_id: params[:id])
    scopus_id = ScopusUsersProtocol.where(users_protocol_id: UsersProtocol.where(protocol_id: params[:id].to_i, user_id: current_user.id).first).select('scopu_id')
    @scopus = studies.where(id: scopus_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @scopu = Scopu.find(params[:id])

    @included = Included.new
    @included.title = @scopu.title
    @included.author = @scopu.author
    @included.pubtitle = @scopu.pubtitle
    @included.protocol_id = @scopu.protocol_id
    @included.link = @scopu.link
    @included.name_database = 'scopus'
    @included.included = 0
    @included.save!

    @scopu.destroy

    redirect_to :back
  end

  def unselect
    @scopu = Scopu.find(params[:id])
    @scopu.destroy

    redirect_to :back
  end

end
