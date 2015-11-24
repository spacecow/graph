class ParticipationsController < ApplicationController
  
  def create
    run(ParticipationRunners::Create, participation_params) do |on|
      on.success do |participation|
        redirect_to event_path(participation.event_id)
      end
    end
    #TODO if failure
  end

  private

    def participation_params
      params.require(:participation).permit(:event_id, :article_id)
    end

end
