class UsersController < ApplicationController
  before_action :set_show_user, only: [:show, :followings, :followers]
  before_action :set_follow, only: [:index, :followings, :followers]

  def index
    @users = User.all
  end

  def show
    @q = Article.where(user_id: @show_user.id).search(params[:q])
    @articles = @q.result(distinct: true).order("created_at DESC")
    @favorites = FavoriteArticle.where(user_id: @show_user.id)
    @follow = Follow.find_by(follower_id: @current_user.id, followee_id: @show_user.id)
    if @show_user.provider?
      @token = @show_user.token
      @graph = Koala::Facebook::API.new(@token)
      @me = @graph.get_object('me')
    end
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
