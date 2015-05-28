module ArticleTypeRunners
  class Index < Runner
    def run
      repo.article_types
    end
  end
end
