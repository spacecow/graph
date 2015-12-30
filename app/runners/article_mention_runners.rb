require_dependency './app/runners/runner'

module ArticleMentionRunners

  class Create < Runner
    def run params 
      repo.save_article_mention params
      success
    end
  end

  class Edit < Runner
    def run id, universe_id:
      mention = repo.article_mention id 
      articles = repo.articles universe_id:universe_id
      success mention, articles
    end
  end

  class Update < Runner
    def run id, params
      repo.update_article_mention id, params 
      success
    end
  end

end
