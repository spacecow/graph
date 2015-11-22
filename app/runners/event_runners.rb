require_dependency './app/runners/runner'

module EventRunners

  class Show < Runner
    def run id
      repo.event id
    end
  end

end
