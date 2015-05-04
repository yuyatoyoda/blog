class CommentsController < ApplicationController
before_action :set_article
before_action :set_comment, only: [:edit, :updpate, :destroy, :comment_favorite, :comment_favorite_delete]

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to article_path(@article.id)
  end

  def edit
  end

  def update
    if @comment = @comment.update(comment_params)
      redirect_to article_path(@article.id)
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article.id)
  end

  def favorite
    @favorite = current_user.favorite_comments.build(comment: @comment)
    if @favorite.save
      redirect_to article_path(@article.id)
    else
      p 'hello'
    end
  end

  def favorite_delete
    @favorite = current_user.favorite_comments.find_by(comment: @comment)
    if @favorite.destroy
      redirect_to article_path(@article.id)
    end
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
