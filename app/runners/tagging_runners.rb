require_dependency './app/runners/runner'

module TaggingRunners

  class New < Runner
    def run params
      repo.new_tagging params
    end
  end

  class Create < Runner
    def run params 
      tagging = repo.new_tagging params
      tagging = repo.save_tagging tagging
      success tagging
    end
  end


end
