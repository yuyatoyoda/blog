class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :favorite, :favorite_delete]

  def index
    @articles = Article.all
    #require 'Gemfile/koala'
    #@facebook = Koala::Facebook::API.new(CAACEdEose0cBAHr69sT4rb3FWLrRhjoUnBYFRX7yQuRXbdxClX8uZBCH5WZBIzp8pK5XFreeZBSwcJhragGrEQDur9jgamSsApLqKBECz7QdKSNxDGYJ0dak9moAI5vRHzsGBfxqkrDy5uVeWVY4jnft6x335kZC6g35dBGr5vRTHClE76E0KZATM0koYXv5jn5efVV2EsuXplTZCtHazG)
    #@me = @facebook.get_object('me')
    @q = Article.search(params[:q])
    @articles = @q.result(distinct: true)
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
   @favorite = current_user.favorite_articles.build(article_id: @article.id)
   @favorite.save
   redirect_to article_path(@article.id)
 end

 def favorite_delete
   @favorite = FavoriteArticle.find_by(user_id: current_user.id, article_id: @article.id)
   @favorite.destroy
   redirect_to article_path(@article.id)
 end

 private

 def article_params
   params[:article].permit(:date, :shinchoku, :kansou, :manabi, :next_do, :next_date, :memo, :article_image, :article_image_cache, :remove_article_image)
 end

 def set_article
   @article = Article.find(params[:id])
 end

end
