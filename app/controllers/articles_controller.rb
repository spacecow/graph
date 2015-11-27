class ArticlesController < ApplicationController

  def show
    redirect_to universes_path and return if current_universe_id.nil?
    run(ArticleRunners::Show, params[:id], universe_id:current_universe_id) do |on|
      on.success do |article, note, notes, relation, targets|
        @article = article
        @note = note
        @notes = notes
        @relation = relation
        @targets = targets
      end
    end
  end

  def new
    redirect_to universes_path and return if current_universe_id.nil?
    run(ArticleRunners::New) do |on|
      on.success do |article, article_types|
        @article = article
        @article_types = article_types
      end
    end
  end

  def create
    redirect_to universes_path and return if current_universe_id.nil?
    run(ArticleRunners::Create, article_params) do |on|
      on.success do
        redirect_to universe_path(current_universe_id)
      end
      on.failure do |article, article_types|
        @article = article 
        @article_types = article_types
        render :new
      end
    end
  end

  private

    def article_params
      params.require(:article).permit(:name, :type).merge({universe_id:current_universe_id})
    end

end
