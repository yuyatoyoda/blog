class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:edit, :updpate, :destroy, :favorite, :favorite_delete]
  before_action :set_current_user, only: [:favorite]

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to article_path(@article.id)
  end

  def edit
  end

  def update
    @comment = @comment.update(comment_params)
    redirect_to article_path(@article.id)
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article.id)
  end

  def favorite
    @favorite = current_user.favorite_comments.build(comment_id: @comment.id)
    @favorite.save
    redirect_to article_path(@article.id)
  end

  def favorite_delete
    @favorite = FavoriteComment.find_by(user_id: current_user.id, comment_id: @comment.id)
    @favorite.destroy
    redirect_to article_path(@article.id)
  end

  private
  def comment_params
    params[:comment].permit(:message)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
