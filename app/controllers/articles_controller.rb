class ArticlesController < ApplicationController
  include ArticleRunners

  def index
    @articles = run(ArticleRunners::Index)
  end

  def new
    @article = run(ArticleRunners::New)
  end

end
