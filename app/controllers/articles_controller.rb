class ArticlesController < ApplicationController
  include ArticleRunners

  def index
    @articles = run(ArticleRunners::Index)
  end

  def new
    @article = run(ArticleRunners::New)
  end

  def create
    article = repo.new_article params[:article]
    repo.save_article article
    redirect_to articles_path
  end

end
