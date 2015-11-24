unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/event_runners'

module EventRunners
describe EventRunners do
  let(:context){ double :context, repo:repo }
  let(:repo){ double :repo }

  describe New do
    before do
      expect(repo).to receive(:new_event).with(no_args){ :event }
      expect(repo).to receive(:events).with(no_args){ :events }
    end
    subject{ New.new(context).run }
    it{ subject }
  end
end

end
