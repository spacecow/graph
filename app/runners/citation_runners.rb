require_dependency './app/runners/runner'

module CitationRunners

  class Create < Runner
    def run params 
      repo.save_citation params
      success 
    end
  end

end
