class TagsController < ApplicationController

  def create
    run(TagRunners::Create, tag_params) do |on|
      on.success do |tag|
        redirect_to note_path(tag.tagable_id)
      end
    end
  end

  private

    def tag_params
      params.require(:tag).permit(:tagable_id, :tagable_type, :title)
    end

end
