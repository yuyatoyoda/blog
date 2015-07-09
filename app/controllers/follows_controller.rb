class FollowsController < ApplicationController
  before_action :set_user
  def create
    if @user.follows.create(follower: @user)
      redirect_to user_path(@user.id), notice: "フォローしました"
    else
      redirect_to user_path(@user.id), alert: "フォローできません"
    end
  end

  def destroy
    follow = @user.follows.find_by(follower: @user.id)
    if follow.destroy
      redirect_to user_path(@user.id), notice: "フォローを解除しました"
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

end
