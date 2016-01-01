class ParticipationsController < ApplicationController
  
  def create
    run(ParticipationRunners::Create, participation_params) do |on|
      on.success do |participation|
        redirect_to event_path(participation.event_id)
      end
    end
    #TODO if failure
  end

  def destroy
    session[:redirect_to] = request.referer || root_path
    run(ParticipationRunners::Destroy, params[:id]) do |on|
      on.success do
        redirect_to session.delete(:redirect_to)
      end
    end
  end

  private

    def participation_params
      params.require(:participation).permit(:event_id, :participant_id, :content)
    end

end
