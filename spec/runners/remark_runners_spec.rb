unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/remark_runners'

module RemarkRunners

  describe RemarkRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }
  
    describe Create do
      subject{ Create.new(context).run :params, :event_id }
      before do
        expect(repo).to receive(:save_remark).with(:params,:event_id){ :remark }
      end
      it{ subject }
    end

    describe Edit do
      subject{ Edit.new(context).run :id, :event_id }
      before do
        expect(repo).to receive(:remark).with(:id, remarkable_id: :event_id).
          and_return(:remark)
      end
      it{ subject }
    end

    describe Update do
      subject{ Update.new(context).run :id, :params }
      before do
        expect(repo).to receive(:update_remark).with(:id,:params)
      end
      it{ subject }
    end

    describe Destroy do
      subject{ Destroy.new(context).run :id }
      before{ expect(repo).to receive(:delete_remark).with(:id) }
      it{ subject }
    end

  end
end
