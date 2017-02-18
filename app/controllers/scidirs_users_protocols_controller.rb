class ScidirsUsersProtocolsController < ApplicationController
  before_action :set_session, only: [:show]
  before_action :set_user_protocol, only: [:show, :select, :unselect]

  def show
    studies = Scidir.where(protocol_id: params[:id])
    scidirs_id = ScidirsUsersProtocol.where(users_protocol_id: @user_protocol, included: nil).select('scidir_id')
    @scidirs = studies.where(id: scidirs_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @scidir = ScidirsUsersProtocol.where(scidir_id: params[:id], users_protocol_id: @user_protocol).first
    @scidir.included = 1
    @scidir.save!

    redirect_to :back
  end

  def unselect
    @scidir = ScidirsUsersProtocol.where(scidir_id: params[:id].to_i, users_protocol_id: @user_protocol).first
    @scidir.included = 0
    @scidir.save!

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
