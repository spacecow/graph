require_dependency './app/runners/runner'

module UniverseRunners

  class Show < Runner
    def run id
      repo.universe id
    end
  end

  class Index < Runner
    def run
      repo.all_universes
    end
  end

  class New < Runner
    def run
      repo.new_universe
    end
  end

  class Create < Runner
    def run universe_params
      universe = repo.new_universe universe_params
      if repo.save_universe universe
        success universe 
      end
    end
  end

end
