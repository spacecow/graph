require_dependency './app/runners/runner'

module ArticleMentionRunners

  class Create < Runner
    def run params 
      repo.save_article_mention params
      success
    end
  end

end
