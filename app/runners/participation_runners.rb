require_dependency './app/runners/runner'

module ParticipationRunners

  class Create < Runner
    def run params
      participation = repo.new_participation params
      participation = repo.save_participation participation
      #success event
    end
  end

end
