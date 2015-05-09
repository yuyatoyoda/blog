class ArticlesController < ApplicationController
  before_action :set_current_user, only: [:index]

  def index
    @articles = Article.all
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
   @article = Article.find(params[:id])
 end

 def edit
   @article = Article.find(params[:id])
 end

 def update
   @article = Article.find(params[:id])
   if @article.update(article_params)
     redirect_to articles_path
   else
     render 'edit'
   end
 end

 def destroy
   @article = Article.find(params[:id])
   @article.destroy
   redirect_to articles_path
 end

 def favorite
   @article = Article.find(params[:id])
   @favorite = current_user.favorite_articles.build(article: @article)
   if @favorite.save
     redirect_to article_path(@article.id)
   end
 end

 def favorite_delete
   @article = Article.find(params[:id])
   @favorite = current_user.favorite_articles.find_by!(article: @article)
   @favorite.destroy
   redirect_to article_path(@article.id)
 end

 private

 def article_params
   params[:article].permit(:date, :shinchoku, :kansou, :manabi, :next_do, :next_date, :memo)
 end

 def set_current_user
   @user = current_user
 end

end
