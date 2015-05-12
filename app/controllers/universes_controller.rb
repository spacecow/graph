class UniversesController < ApplicationController
  include UniverseRunners

  def index
    @universes = run(Index)
    @current_universe = params[:id]
  end

  def new
    @universe = run(New) 
  end

  def create
    run(Create, params[:universe]) do |on|
      on.success { |universe|
        redirect_to universes_path
      } 
      on.failure { |universe|
      }
    end
  end

end
