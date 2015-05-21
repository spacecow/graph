class ArticlesController < ApplicationController
  include ArticleRunners

  def index
    @articles = run(Index)
  end

  def new
    @article = run(New)
  end

end
