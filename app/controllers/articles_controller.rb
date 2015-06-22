class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :favorite, :favorite_delete]

  def index
    @articles = Article.all.order("created_at DESC")
    #@token = @user.token
    #@graph = Koala::Facebook::API.new(@token)
    #@me = @graph.get_object('me')
    #@me2 = @graph.get_picture('me')
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
   else
     render 'new'
   end
 end

 def show
   @favorite = FavoriteArticle.where(article_id: @article.id)
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

 def privacy
 end

 private

 def article_params
   params[:article].permit(:date, :shinchoku, :kansou, :manabi, :next_do, :next_date, :memo, :article_image, :article_image_cache, :remove_article_image)
 end

 def set_article
   @article = Article.find(params[:id])
 end

end
