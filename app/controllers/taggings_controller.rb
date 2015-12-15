class TaggingsController < ApplicationController

  def create
    session[:redirect_to] = request.referer || root_path
    run(TaggingRunners::Create, tagging_params) do |on|
      on.success do |tagging|
        redirect_to session.delete(:redirect_to)
      end
    end
  end

  private

    def tagging_params
      params.require(:tagging).permit(:tagable_type, :tagable_id, :tag_id)
    end

end
