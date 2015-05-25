class UniversesController < ApplicationController
  include UniverseRunners

  def show
    current_universe_id params[:id]
    @universe = run(UniverseRunners::Show, params[:id])
    @articles = @universe.articles 
  end

  def index
    @universes = run(UniverseRunners::Index)
    current_universe_id params[:id]
  end

  def new
    @universe = run(UniverseRunners::New) 
  end

  def create
    run(UniverseRunners::Create, params[:universe]) do |on|
      on.success { |universe|
        redirect_to universes_path
      } 
      on.failure { |universe|
      }
    end
  end

end
