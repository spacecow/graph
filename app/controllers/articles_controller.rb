class ArticlesController < ApplicationController

  def show
    redirect_to universes_path and return if current_universe_id.nil?
    run(ArticleRunners::Show, params[:id], universe_id:current_universe_id) do |on|
      on.success do |article, note, notes, relation, relation_targets, events, relation_types, relations, article_tags, tagging, tags, citation, citation_targets|
        @article = article
        @note = note
        @notes = notes
        @relation = relation
        @relation_targets = relation_targets
        @events = events
        @relation_types = relation_types 
        @relations = relations
        @article_tags = article_tags
        @tagging = tagging
        @tags = tags
        @citation = citation
        @citation_targets = citation_targets
      end
    end
  end

  def index
    redirect_to universes_path and return if current_universe_id.nil?
    run(ArticleRunners::Index, current_universe_id, article_id:params[:article_id], target_ids:params[:target_ids]) do |on|
      on.success do |targets|
        respond_to do |f|
          f.json {render json:targets.select{|e| e[:name].downcase.include?(params[:q].downcase)}}
        end
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
      on.success do |article|
        redirect_to article_path(article.id)
      end
      on.failure do |article, article_types|
        @article = article 
        @article_types = article_types
        render :new
      end
    end
  end

  def edit
    redirect_to universes_path and return if current_universe_id.nil?
    run(ArticleRunners::Edit, params[:id]) do |on|
      on.success do |article, article_types|
        @article = article
        @article_types = article_types
      end
    end
  end

  def update
    redirect_to universes_path and return if current_universe_id.nil?
    run(ArticleRunners::Update, params[:id], article_params) do |on|
      on.success do |article|
        redirect_to article_path(article.id)
      end
    end
  end

  private

    def article_params
      params.require(:article).permit(:name, :type, :gender).
        merge({universe_id:current_universe_id})
    end

end
