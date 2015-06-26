class UsersController < ApplicationController
  before_action :set_show_user
  before_action :set_follow, only: [:index, :followings, :followers]

  def index
    @users = User.all
  end

  def show
    @articles = Article.where(user_id: @show_user.id)
    @favorites = FavoriteArticle.where(user_id: @show_user.id)
    @follow = Follow.find_by(follower_id: @current_user.id, followee_id: @show_user.id)
    @token = @show_user.token
    @graph = Koala::Facebook::API.new(@token)
    @me = @graph.get_object('me')
  end
  def followings
    @follows = Follow.where(follower_id: @show_user.id)
  end

  def followers
    @follows = Follow.where(followee_id: @show_user.id)
  end

  private
  def set_show_user
    @show_user = User.find(params[:id])
  end

  def set_follow
    @follow = Follow.find_by(follower_id: @current_user.id)
  end
end
