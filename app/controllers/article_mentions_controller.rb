class ArticleMentionsController < ApplicationController

  def create
    session[:redirect_to] = request.referer || root_path
    run(ArticleMentionRunners::Create, mention_params) do |on|
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
