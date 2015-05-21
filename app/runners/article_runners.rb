require_dependency './app/runners/runner'

module ArticleRunners
  class Index < Runner
    def run
      repo.all_articles
    end
  end

  class New < Runner
    def run
      repo.new_article
    end
  end
end
