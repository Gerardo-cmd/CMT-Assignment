class ArticlesController < ApplicationController
  def index
    #Whatever is initialized and declared here can be used in the view!
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
