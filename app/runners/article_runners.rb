require_dependency './app/runners/runner'

module ArticleRunners

  class Show < Runner
    def run id, universe_id:
      article = repo.article id
      note = repo.new_note article_id:article.id 
      notes = article.notes
      relation = repo.new_relation origin_id:article.id
      citation_targets = repo.articles(universe_id:universe_id).
        reject{|e| e.id==article.id}
      relation_targets = citation_targets.
        reject{|e| article.target_ids.include?(e.id)}
      events = article.events
      types = repo.relation_types
      relation_types = types.map{|e| e.gsub(/_/,' ')}.zip(types)
      relations = article.relations
      article_tags = article.tags
      tagging = repo.new_tagging tagable_id:article.id, tagable_type:"Article"
      tags = repo.tags
      citation = repo.new_citation origin_id:article.id
      success article, note, notes, relation, relation_targets, events, relation_types, relations, article_tags, tagging, tags, citation, citation_targets
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
        success article
      else
        article_types = repo.article_types
        failure article, article_types
      end
    end
  end

  class Edit < Runner
    def run id
      article = repo.article id
      article_types = repo.article_types
      success article, article_types
    end
  end

  class Update < Runner
    def run id, params
      article = repo.article id 
      repo.update_article article, params 
      success article
    end
  end

end
