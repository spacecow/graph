class EventsController < ApplicationController

  def show
    return redirect_to universes_path if current_universe_id.nil?
    run(EventRunners::Show, params[:id], universe_id:current_universe_id) do |on|
      on.success do |event, articles, participation|
        @event         = event
        @articles      = articles
        @participation = participation
      end
    end
  end

  def index
    @events = run(EventRunners::Index, universe_id:current_universe_id)
  end

  def new
    #TODO change events to parents
    return redirect_to universes_path if current_universe_id.nil?
    run(EventRunners::New, universe_id:current_universe_id) do |on|
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
      params.require(:event).permit(:title, :parent_tokens, :child_tokens).
        merge({universe_id:current_universe_id})
    end

end
