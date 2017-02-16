class SpringersUsersProtocolsController < ApplicationController

  def show
    studies = Springer.where(protocol_id: params[:id])
    springers_id = SpringersUsersProtocol.where(users_protocol_id: UsersProtocol.where(protocol_id: params[:id].to_i, user_id: current_user.id).first).select('springer_id')
    @springers = studies.where(id: springers_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @springer = Springer.find(params[:id])

    @included = Included.new
    @included.title = @springer.title
    @included.author = @springer.author
    @included.pubtitle = @springer.pubtitle
    @included.protocol_id = @springer.protocol_id
    @included.link = @springer.link
    @included.name_database = 'springer'
    @included.included = 0
    @included.save!

    @springer.destroy

    redirect_to :back
  end

  def unselect
    @springer = Springer.find(params[:id])
    @springer.destroy

    redirect_to :back
  end
end
