require_dependency './app/runners/runner'

module ReferenceRunners

  class New < Runner
    def run params
      repo.new_reference params
    end
  end

  class Create < Runner
    def run params 
      reference = repo.new_reference params
      reference = repo.save_reference reference
      success reference
    end
  end

end
