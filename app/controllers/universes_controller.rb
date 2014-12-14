class UniversesController < ApplicationController
  include UniverseRunners

  def index
    @universes = run(Index)
    current_universe params[:id]
  end

  def new
    @universe = run(New) 
  end

  def create
    @universe = run(New) 
    redirect_to universes_path
  end

end
