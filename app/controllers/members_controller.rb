class MembersController < ApplicationController
  before_action :authenticate_member!
  def index
    @member = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    redirect_to members_path if current_member.id != params[:id].to_i
  end

end
