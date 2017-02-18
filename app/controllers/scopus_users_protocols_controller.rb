class ScopusUsersProtocolsController < ApplicationController
  before_action :set_session, only: [:show]
  before_action :set_user_protocol, only: [:show, :select, :unselect, :include, :exclude]

  def show
    studies = Scopu.where(protocol_id: params[:id])
    scopus_id = ScopusUsersProtocol.where(users_protocol_id: @user_protocol, pre_selected: nil).select('scopu_id')
    @scopus = studies.where(id: scopus_id).paginate(:page => params[:page], per_page: 10)

    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @scopu = ScopusUsersProtocol.where(scopu_id: params[:id], users_protocol_id: @user_protocol).first
    @scopu.pre_selected = 1
    @scopu.save!

    redirect_to :back
  end

  def unselect
    @scopu = ScopusUsersProtocol.where(scopu_id: params[:id].to_i, users_protocol_id: @user_protocol).first
    @scopu.pre_selected = 0
    @scopu.save!

    redirect_to :back
  end

  def include
    @scopu = ScopusUsersProtocol.where(scopu_id: params[:id], users_protocol_id: @user_protocol).first
    @scopu.included = 1
    @scopu.save!

    redirect_to :back
  end

  def exclude
    @scopu = ScopusUsersProtocol.where(scopu_id: params[:id].to_i, users_protocol_id: @user_protocol).first
    @scopu.included = 0
    @scopu.save!

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
