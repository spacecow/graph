require_dependency './app/runners/runner'

module MentionRunners

  class Create < Runner
    def run params 
      mention = repo.save_mention params
      success mention
    end
  end

end
