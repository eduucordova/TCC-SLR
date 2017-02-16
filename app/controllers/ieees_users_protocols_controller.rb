class IeeesUsersProtocolsController < ApplicationController

  def show
    studies = Ieee.where(protocol_id: params[:id])
    ieees_id = IeeesUsersProtocol.where(users_protocol_id: UsersProtocol.where(protocol_id: params[:id].to_i, user_id: current_user.id).first).select('ieee_id')
    @ieees = studies.where(id: ieees_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    studies = Ieee.find(params[:id]).joins()

    @ieees = IeeesUsersProtocol.joins(ieee_id: studies)

byebug
  end
end