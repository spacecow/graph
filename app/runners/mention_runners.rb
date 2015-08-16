require_dependency './app/runners/runner'

module MentionRunners

  class Create < Runner
    def run params 
      mention = repo.new_mention params
      mention = repo.save_mention mention
      success mention
    end
  end

end
