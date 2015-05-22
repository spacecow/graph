class UniversesController < ApplicationController
  include UniverseRunners

  def index
    @universes = run(UniverseRunners::Index)
    current_universe_id params[:id]
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
