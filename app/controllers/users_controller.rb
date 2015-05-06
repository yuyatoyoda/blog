class UsersController < ApplicationController
  before_action :set_current_user
  before_action :set_show_user, only: [:followings, :followers]
  before_action :set_follows, only: [:followings, :followers]
  before_action :set_follow, only: [:index, :followings, :followers]
  def index
    @users = User.all
  end

  def show
    @show_user = User.find(params[:id])
    @favorites = FavoriteArticle.where(user_id: @show_user.id)
    @follow = Follow.find_by(follower_id: @current_user.id, followee_id: @show_user.id)
  end
  def followings
  end

  def followers
  end

  private
  def set_current_user
    @current_user = current_user
  end
  
  def set_show_user
    @show_user = User.find(params[:id])
  end

  def set_follows
    @follows = Follow.all
  end

  def set_follow
    @follow = Follow.find_by(follower_id: @current_user.id)
  end
end
