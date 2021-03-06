require_dependency './app/runners/runner'

module EventRunners

  class Show < Runner
    def run id, universe_id:
      event = repo.event id
      all_events = repo.events(universe_id:universe_id)
      all_articles = repo.articles(universe_id:universe_id)
      events = event.available_events(all_events)
      articles = event.available_articles(all_articles)
      participation = repo.new_participation event_id:event.id 
      participations = event.participations
      parent_step = repo.new_step child_id:event.id
      notes = event.notes
      note = repo.new_note event_id:event.id 
      mention = repo.new_mention origin_id:event.id
      article_mention = repo.new_article_mention origin_id:event.id
      success event, events, articles, participation, participations, parent_step, notes, note, mention, article_mention
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

  class Edit < Runner
    def run id
      event = repo.event id
      success event
    end
  end

  class Update < Runner
    def run id, params
      event = repo.update_event id, params 
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
