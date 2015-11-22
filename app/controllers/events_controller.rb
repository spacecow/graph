class EventsController < ApplicationController

  def show
    @event = run(EventRunners::Show, params[:id])
  end

end
