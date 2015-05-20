require_dependency './app/runners/runner'

module ArticleRunners
  class New < Runner
    def run
      repo.new_article
    end
  end
end
