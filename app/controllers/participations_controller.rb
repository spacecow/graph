class ParticipationsController < ApplicationController
  
  def create
    run(ParticipationRunners::Create, participation_params) do |on|
      on.success do |participation|
        redirect_to event_path(participation.event_id)
      end
    end
    #TODO if failure
  end

  def edit
    session[:redirect_to] = request.referer || root_path
    run(ParticipationRunners::Edit, params[:id], universe_id:current_universe_id) do |on|
      on.success do |participation, articles|
        @participation = participation
        @articles = articles
      end
    end
  end

  def update
    run(ParticipationRunners::Update, params[:id], participation_params) do |on|
      on.success do
        redirect_to session.delete(:redirect_to)
      end
    end
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
