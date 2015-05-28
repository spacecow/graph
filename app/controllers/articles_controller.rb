class ArticlesController < ApplicationController
  include ArticleRunners

  def new
    restrict_access
    @article = run(ArticleRunners::New)
    @article_types = run(ArticleTypeRunners::Index)
  end

  def create
    restrict_access
    run(ArticleRunners::Create, article_params) do |on|
      on.success do
        redirect_to universe_path(current_universe_id)
      end
      on.failure do |article|
        @article = article 
        @article_types = run(ArticleTypeRunners::Index)
        render :new
      end
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
