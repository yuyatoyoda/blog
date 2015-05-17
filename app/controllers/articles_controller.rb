class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :favorite, :favorite_delete]

  def index
    @articles = Article.all
    @graph = Koala::Facebook::API.new("CAACEdEose0cBAKhWTUigDDPkfHAfTLXAHZAE9OEhh56AKNturo82UCqS7ic3S4eYk7ulQj8WOu8sX2UCiFGmWjZCK1izC8dDN5uxxdWPpZCL7x8NhmHrZA4qrGLlkaD8GuZCT5mpKGNcQZCZBb8hmB8oTnTKLuLRXkf3B8wOy9OOU1WvJiZAB3Nimi2ZB28H1sjdxL41g2BRbUupIrkKDNXBv")
    @me = @graph.get_object('me')
    @me2 = @graph.get_picture('me')
    @user.update(name: @me['name'])
    @user.remote_image_url= @me2
    @user.save
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
