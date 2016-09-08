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

  class Edit < Runner
    def run id
      mdl = repo.relation id 
      types = repo.relation_types
      relation_types = types.map{|e| e.underscore.humanize}.zip(types)
      success mdl, relation_types
    end
  end

  class Update < Runner
    def run id, params
      repo.update_relation id, params 
    end
  end

  class Invert < Runner
    def run id
      repo.invert_relation id
    end
  end

end
