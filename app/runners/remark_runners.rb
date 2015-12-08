require_dependency './app/runners/runner'

module RemarkRunners

  class Create < Runner
    def run params, event_id
      repo.save_remark params, event_id
      success
    end
  end

end
