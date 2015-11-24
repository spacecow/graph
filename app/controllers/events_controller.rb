class EventsController < ApplicationController

  def show
    return redirect_to universes_path if current_universe_id.nil?
    @event = run(EventRunners::Show, params[:id])
    @articles = run(ArticleRunners::Index, universe_id:current_universe_id).
      reject{|e| @event.participants.map(&:id).include? e.id}
    @participation = run(ParticipationRunners::New, event_id:@event.id)
  end

  def new
    run(EventRunners::New) do |on|
      on.success do |event, events|
        @event = event
        @events = events 
      end
    end
  end

  def create
    return redirect_to universes_path if current_universe_id.nil?
    run(EventRunners::Create, event_params) do |on|
      on.success do |event|
        redirect_to event_path(event.id)
      end
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :parent_id).
        merge({universe_id:current_universe_id})
    end

end
