require_dependency './app/runners/runner'

module TagRunners

  class Show < Runner
    def run id
      repo.tag id
    end
  end

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

  class Destroy < Runner
    def run id, params 
      repo.delete_tag id, params 
    end
  end

end
