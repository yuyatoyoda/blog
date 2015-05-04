class UsersController < ApplicationController
  before_action :set_current_user
  def index
    @users = User.all
  end

  def show
    @show_user = User.find(params[:id])
    @favorites = FavoriteArticle.where(user_id: @show_user.id)
  end

  private
  def set_current_user
    @user = current_user
  end
end
