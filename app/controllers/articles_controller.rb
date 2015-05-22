class ArticlesController < ApplicationController
  include ArticleRunners

  def index
    restrict_access
    @articles = run(ArticleRunners::Index)
  end

  def new
    restrict_access
    @article = run(ArticleRunners::New)
  end

  def create
    restrict_access
    article = repo.new_article params[:article].merge({universe_id:current_universe_id})
    repo.save_article article
    redirect_to articles_path
  end

  private

    def restrict_access
      redirect_to universes_path and return if current_universe_id.nil?
    end

end
