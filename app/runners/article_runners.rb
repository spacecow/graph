require_dependency './app/runners/runner'

module ArticleRunners

  class Show < Runner
    def run id
      repo.article id
    end
  end

  class Index < Runner
    def run universe_id:
      repo.articles universe_id:universe_id
    end
  end

  class New < Runner
    def run
      repo.new_article
    end
  end

  class Create < Runner
    def run article_params
      article = repo.new_article article_params
      article = repo.save_article article
      if article.errors.empty?
        success
      else
        failure article
      end
    end
  end

end
