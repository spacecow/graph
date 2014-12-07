class UniversesController < ApplicationController
  include UniverseRunners

  def index
    @universes = run(Index)
  end

  def new
  end

end
