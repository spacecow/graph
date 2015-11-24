class ParticipationsController < ApplicationController
  
  def create
    participation = run(ParticipationRunners::Create, participation_params)
    #TODO if success
    redirect_to event_path(participation.event_id)
  end

  private

    def participation_params
      params.require(:participation).permit(:event_id, :article_id)
    end

end
