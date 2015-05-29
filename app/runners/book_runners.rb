module BookRunners
  class Index < Runner
    def run universe_id
      repo.books universe_id
    end
  end
end
