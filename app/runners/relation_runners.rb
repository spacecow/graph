require_dependency './app/runners/runner'

module RelationRunners

  class Create < Runner
    def run params
      relation = repo.new_relation params
      relation = repo.save_relation relation
      success relation
    end
  end

end
