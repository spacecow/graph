require_dependency './app/runners/runner'

module RelationRunners

  class Show < Runner
    def run id
      relation = repo.relation id
      reference = repo.new_reference(
        referenceable_id:id, referenceable_type:"Relation")
      references = relation.references
      success relation, reference, references
    end
  end

  class Create < Runner
    def run params
      relation = repo.save_relation params 
      success relation
    end
  end

  class Invert < Runner
    def run id
      repo.invert_relation id
    end
  end

end
