class MentionsController < ApplicationController

  def create
    run(MentionRunners::Create, mention_params) do |on|
      on.success do |mention|
        redirect_to event_path(mention.origin_id)
      end
    end
  end

  private

    def mention_params
      params.require(:mention).permit(:origin_id, :target_id, :content)
    end

end
