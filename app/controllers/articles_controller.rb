class ArticlesController < ApplicationController
  include ArticleRunners

  def index
  end

  def new
    @article = run(New)
  end

end
