require_dependency './app/runners/runner'

module UniverseRunners
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
end
