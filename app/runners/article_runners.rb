require_dependency './app/runners/runner'

module ArticleRunners

  class Show < Runner
    def run id, universe_id:
      article = repo.article id
      note = repo.new_note article_id:article.id 
      notes = article.notes
      relation = repo.new_relation origin_id:article.id
      targets = repo.articles(universe_id:universe_id).
        reject{|e| e.id==article.id}.
        reject{|e| article.target_ids.include?(e.id)}
      events = article.events
      relation_types = repo.relation_types
      relations = article.relations
      success article, note, notes, relation, targets, events, relation_types, relations
    end
  end

  class New < Runner
    def run
      article = repo.new_article
      article_types = repo.article_types
      success article, article_types
    end
  end

  class Create < Runner
    def run article_params
      article = repo.new_article article_params
      article = repo.save_article article
      if article.errors.empty?
        success
      else
        article_types = repo.article_types
        failure article, article_types
      end
    end
  end

end
