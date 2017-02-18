class IeeesUsersProtocolsController < ApplicationController
  before_action :set_session, only: [:show]
  before_action :set_user_protocol, only: [:show, :select, :unselect, :include, :exclude]

  def show
    studies = Ieee.where(protocol_id: params[:id])
    ieees_id = IeeesUsersProtocol.where(users_protocol_id: @user_protocol, pre_selected: nil).select('ieee_id')
    @ieees = studies.where(id: ieees_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @ieee = IeeesUsersProtocol.where(ieee_id: params[:id], users_protocol_id: @user_protocol).first
    @ieee.pre_selected = 1
    @ieee.save!

    redirect_to :back
  end

  def unselect
    @ieee = IeeesUsersProtocol.where(ieee_id: params[:id].to_i, users_protocol_id: @user_protocol).first
    @ieee.pre_selected = 0
    @ieee.save!

    redirect_to :back
  end

  def include
    @ieee = IeeesUsersProtocol.where(ieee_id: params[:id], users_protocol_id: @user_protocol).first
    @ieee.included = 1
    @ieee.save!

    redirect_to :back
  end

  def exclude
    @ieee = IeeesUsersProtocol.where(ieee_id: params[:id].to_i, users_protocol_id: @user_protocol).first
    @ieee.included = 0
    @ieee.save!

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