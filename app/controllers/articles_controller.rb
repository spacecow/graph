class ArticlesController < ApplicationController
  include ArticleRunners

  def new
    restrict_access
    @article = run(ArticleRunners::New)
  end

  def create
    restrict_access
    article = repo.new_article article_params
    @article = repo.save_article article
    if @article.errors.empty?
      redirect_to universe_path(current_universe_id)
    else
      render :new
    end
  end

  private

    def restrict_access
      redirect_to universes_path and return if current_universe_id.nil?
    end

    def article_params
      params.require(:article).merge({universe_id:current_universe_id})
    end

end
