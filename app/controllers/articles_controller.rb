class ArticlesController < ApplicationController
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

 private

 def article_params
   params[:article].permit(:date, :shinchoku, :kansou, :manabi, :next_do, :next_date, :memo)
 end

end
