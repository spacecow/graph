class MentionsController < ApplicationController

  def create
    run(MentionRunners::Create, mention_params) do |on|
      on.success do |mention|
        redirect_to universes_path #note_path mention.note_id
      end
    end
  end

  private

    def mention_params
      params.require(:mention).permit(:image_data)
    end

end
