class EventsController < ApplicationController

  def show
    return redirect_to universes_path if current_universe_id.nil?
    run(EventRunners::Show, params[:id], universe_id:current_universe_id) do |on|
      on.success do |event, events, articles, participation, participations, parent_step, notes, note, mention|
        @event          = event
        @events         = events
        @articles       = articles
        @participation  = participation
        @participations = participations 
        @parent_step    = parent_step
        @notes          = notes
        @note           = note
        @mention        = mention
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

  def edit
    return redirect_to universes_path if current_universe_id.nil?
    run(EventRunners::Edit, params[:id]) do |on|
      on.success do |event|
        @event = event
      end
    end
  end

  def update
    return redirect_to universes_path if current_universe_id.nil?
    run(EventRunners::Update, params[:id], event_params) do |on|
      on.success do |event|
        redirect_to event_path(event.id)
      end
    end
  end

  def destroy
    run(EventRunners::Destroy, params[:id]) do |on|
      on.success do
        redirect_to events_path
      end
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :parent_tokens, :child_tokens).
        merge({universe_id:current_universe_id})
    end

end
