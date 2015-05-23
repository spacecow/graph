require_dependency './app/runners/runner'

module ArticleRunners
  class Index < Runner
    def run universe_id
      repo.all_articles universe_id
    end
  end

  class New < Runner
    def run
      repo.new_article
    end
  end
end
