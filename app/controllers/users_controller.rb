class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @show_user = User.find(params[:id])
    @favorites = FavoriteArticle.where(user_id: @show_user.id)
  end

end
