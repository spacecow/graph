require_dependency './app/runners/runner'

module ArticleRunners
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
