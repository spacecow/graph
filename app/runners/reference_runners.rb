require_dependency './app/runners/runner'

module ReferenceRunners

  class Show < Runner
    def run id
      repo.reference id
    end
  end

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

  class Update < Runner
    def run id, params 
      reference = repo.new_reference params.merge({id:id})
      reference = repo.update_reference reference
      success reference
    end
  end

end
