class UniversesController < ApplicationController
  include UniverseRunners

  def index
    @universes = run(Index)
  end

  def new
    @universe = run(New) 
  end

end
