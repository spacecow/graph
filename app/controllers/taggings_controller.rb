class TaggingsController < ApplicationController

  def create
    run(TaggingRunners::Create, tagging_params) do |on|
      on.success do |tagging|
        redirect_to note_path(tagging.note_id)
      end
    end
  end

  private

    def tagging_params
      params.require(:tagging).permit(:tagable_type, :tagable_id, :tag_id)
    end

end
