class ArticlesController < ApplicationController
  include ArticleRunners

  def new
    @article = run(New)
  end

end
