require_dependency './app/runners/runner'

module TagRunners

  class Index < Runner
    def run
      repo.tags
    end
  end

  class New < Runner
    def run params={}
      repo.new_tag params
    end
  end

  class Create < Runner
    def run params 
      tag = repo.new_tag params
      tag = repo.save_tag tag
      success tag
    end
  end


end
