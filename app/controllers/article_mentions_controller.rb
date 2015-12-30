class ArticleMentionsController < ApplicationController

  def create
    session[:redirect_to] = request.referer || root_path
    run(ArticleMentionRunners::Create, mention_params) do |on|
      on.success do
        redirect_to session.delete(:redirect_to)
      end
    end
  end

  def edit
    session[:redirect_to] = request.referer || root_path
    run(ArticleMentionRunners::Edit, params[:id], universe_id:current_universe_id) do |on|
      on.success do |mention, articles|
        @mention = mention
        @articles = articles
      end
    end
  end

  def update
    run(ArticleMentionRunners::Update, params[:id], mention_params) do |on|
      on.success do
        redirect_to session.delete(:redirect_to)
      end
    end
  end

  private

    def mention_params
      params.require(:article_mention).permit(:origin_id, :target_id, :content)
    end

end
