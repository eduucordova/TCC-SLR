class SpringersUsersProtocolsController < ApplicationController
  before_action :set_session, only: [:show]
  before_action :set_user_protocol, only: [:show, :select, :unselect]

  def show
    studies = Springer.where(protocol_id: params[:id])
    springers_id = SpringersUsersProtocol.where(users_protocol_id: @user_protocol, included: nil).select('springer_id')
    @springers = studies.where(id: springers_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @springer = SpringersUsersProtocol.where(springer_id: params[:id], users_protocol_id: @user_protocol).first
    @springer.included = 1
    @springer.save!

    redirect_to :back
  end

  def unselect
    @springer = SpringersUsersProtocol.where(springer_id: params[:id].to_i, users_protocol_id: @user_protocol).first
    @springer.included = 0
    @springer.save!

    redirect_to :back
  end

  private
  def set_user_protocol
    @user_protocol = UsersProtocol.where(protocol_id: session[:protocol_id], user_id: current_user.id).first
  end
  def set_session
    session[:protocol_id] = params[:id].to_i
  end
end
