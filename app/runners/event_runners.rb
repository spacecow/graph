require_dependency './app/runners/runner'

module EventRunners

  class Show < Runner
    def run id, universe_id:
      event = repo.event id
      articles = repo.articles(universe_id:universe_id).
        reject{|e| event.participant_ids.include? e.id}
      participation = repo.new_participation event_id:event.id 
      parent_step = repo.new_step child_id:event.id
      parents     = repo.events(universe_id:universe_id).
        reject{|e| e.id==event.id}.
        reject{|e| event.parent_ids.include?(e.id)}
      success event, articles, participation, parent_step, parents
    end
  end

  class Index < Runner
    def run universe_id:
      repo.events universe_id:universe_id
    end
  end

  class New < Runner
    def run universe_id:
      event = repo.new_event
      events = repo.events universe_id:universe_id
      success event, events
    end
  end

  class Create < Runner
    def run params 
      event = repo.new_event params
      event = repo.save_event event
      success event
    end
  end

  class Destroy < Runner
    def run id
      repo.delete_event id
      success
    end
  end






end
