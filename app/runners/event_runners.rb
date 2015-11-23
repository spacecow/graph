require_dependency './app/runners/runner'

module EventRunners

  class Show < Runner
    def run id
      repo.event id
    end
  end

  class Index < Runner
    def run
      repo.events
    end
  end

  class New < Runner
    def run
      repo.new_event
    end
  end

  class Create < Runner
    def run params 
      event = repo.new_event params
      event = repo.save_event event
      success event
    end
  end



end
