class AcmsUsersProtocolsController < ApplicationController
  before_action :set_session, only: [:show]
  before_action :set_user_protocol, only: [:show, :select, :unselect]

  def show
    studies = Acm.where(protocol_id: params[:id])
    acms_id = AcmsUsersProtocol.where(users_protocol_id: @user_protocol, included: nil).select('acm_id')
    @acms = studies.where(id: acms_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @acm = AcmsUsersProtocol.where(acm_id: params[:id], users_protocol_id: @user_protocol).first
    @acm.included = 1
    @acm.save!

    redirect_to :back
  end

  def unselect
    @acm = AcmsUsersProtocol.where(acm_id: params[:id].to_i, users_protocol_id: @user_protocol).first
    @acm.included = 0
    @acm.save!

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
