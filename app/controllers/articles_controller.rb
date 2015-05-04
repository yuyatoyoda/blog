class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :favorite, :favorite_delete]

  def index
    @articles = Article.all
    @user = current_user
  end

  def new
    @article = Article.new
  end

 def create
   @article = Article.new(article_params)
   @article.user = current_user
   if @article.save
     redirect_to articles_path
   end
 end

 def show
   @user = current_user
 end

 def edit
 end

 def update
   if @article.update(article_params)
     redirect_to articles_path
   else
     render 'edit'
   end
 end

 def destroy
   @article.destroy
   redirect_to articles_path
 end

 def favorite
   @favorite = current_user.favorite_articles.build(article: @article)
   if @favorite.save
     redirect_to article_path(@article.id)
   end
 end

 def favorite_delete
   @favorite = current_user.favorite_articles.find_by(article: @article)
   if @favorite.destroy
     redirect_to article_path(@article.id)
   end
 end

 private

 def article_params
   params[:article].permit(:date, :shinchoku, :kansou, :manabi, :next_do, :next_date, :memo)
 end

 def set_article
   @article = Article.find(params[:id])
 end
end
