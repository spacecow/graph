require_dependency './app/runners/runner'

module RemarkRunners

  class Create < Runner
    #TODO change to remarkable_id
    def run params, event_id
      repo.save_remark params, event_id
      success
    end
  end

  class Edit < Runner
    def run id, event_id 
      remark = repo.remark id, remarkable_id:event_id 
      success remark
    end
  end

  class Update < Runner
    def run id, params
      repo.update_remark id, params 
      success
    end
  end

end
