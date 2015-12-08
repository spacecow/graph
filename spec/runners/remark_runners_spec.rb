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

  end

end
