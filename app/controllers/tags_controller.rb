class TagsController < ApplicationController

  def show
    @tag = run(TagRunners::Show, params[:id])
    @notes = @tag.notes
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

  def destroy
    session[:redirect_to] = request.referer || root_path
    run(TagRunners::Destroy, params[:id], delete_tag_params) 
    redirect_to session.delete(:redirect_to)
  end

  private

    def delete_tag_params
      params.require(:tag).permit(:tagable_type, :tagable_id)
    end

    def tag_params
      params.require(:tag).permit(:tagable_id, :tagable_type, :title)
    end

end
