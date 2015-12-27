class CitationsController < ApplicationController

  def create
    session[:redirect_to] = request.referer || root_path
    run(CitationRunners::Create, citation_params) do |on|
      on.success do
        redirect_to session.delete(:redirect_to)
      end
    end
  end

  private

    def citation_params
      params.require(:citation).permit(:content,:origin_id,:target_id)
    end

end
