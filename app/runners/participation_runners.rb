require_dependency './app/runners/runner'

module ParticipationRunners

  class Create < Runner
    def run params
      participation = repo.new_participation params
      participation = repo.save_participation participation
      success participation
    end
  end

  class Edit < Runner
    def run id, universe_id:
      participation = repo.participation id 
      articles = repo.articles(universe_id:universe_id)
      success participation, articles
    end
  end

  class Update < Runner
    def run id, params
      repo.update_participation id, params 
      success
    end
  end

  class Destroy < Runner
    def run id
      repo.delete_participation id
      success
    end
  end

end
