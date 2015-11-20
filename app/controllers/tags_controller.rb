class TagsController < ApplicationController

  def show
  end

  def index
    @tags = run(TagRunners::Index)
  end

  def new
    @tag = run(TagRunners::New)
  end

  def create
    run(TagRunners::Create, tag_params) do |on|
      on.success do
        redirect_to tags_path
      end
    end
  end

  private

    def tag_params
      params.require(:tag).permit(:tagable_id, :tagable_type, :title)
    end

end
