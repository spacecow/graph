require_dependency './app/runners/runner'

module StepRunners

  class Create < Runner
    def run params
      step = repo.new_step params
      step = repo.save_step step
      success step
    end
  end

end
