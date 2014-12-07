require_dependency './app/runners/runner'

module UniverseRunners
  class Index < Runner
    def run
      repo.all_universes
    end
  end
end
