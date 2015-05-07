class UniversesController < ApplicationController
  include UniverseRunners

  def index
    @universes = run(Index)
    current_universe params[:id]
  end

  def new
    @universe = run(New) 
  end

end
