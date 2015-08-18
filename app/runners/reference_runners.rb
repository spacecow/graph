require_dependency './app/runners/runner'

module ReferenceRunners

  class Create < Runner
    def run params 
      reference = repo.new_reference params
      reference = repo.save_reference reference
      success reference
    end
  end

end
