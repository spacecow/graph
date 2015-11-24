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

    describe Show do
      let(:event){ double :event, id: :event_id }
      let(:article){ double :article, id: :article_id }
      before do
        expect(repo).to receive(:event).with(:id){ event }
        expect(repo).to receive(:articles).
          with(universe_id: :universe_id){ [article] }
        expect(event).to receive(:participant_ids).with(no_args){ [:id] }
        expect(repo).to receive(:new_participation).
          with(event_id: :event_id){ :participation }
      end
      subject{ Show.new(context).run :id, universe_id: :universe_id }
      it{ subject }
    end
  end

end
