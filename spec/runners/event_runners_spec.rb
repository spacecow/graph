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

    describe Show do
      let(:event){ double :event, id: :event_id }
      let(:article){ double :article, id: :article_id }
      let(:parent_event){ double :parent_event, id: :parent_event_id }
      before do
        expect(repo).to receive(:event).with(:id){ event }
        expect(repo).to receive(:new_remark).with(no_args){ :remark }
        expect(repo).to receive(:articles).
          with(universe_id: :universe_id){ [article] }
        expect(event).to receive(:participant_ids).
          with(no_args){ [:participant_id] }
        expect(event).to receive(:parent_ids).with(no_args){ [:parent_id] }
        expect(event).to receive(:remarks).with(no_args){ :remarks }
        expect(event).to receive(:notes).with(no_args){ :notes }
        expect(repo).to receive(:new_participation).
          with(event_id: :event_id){ :participation }
        expect(repo).to receive(:new_step).
          with(child_id: :event_id){ :parent_step }
        expect(repo).to receive(:events).
          with(universe_id: :universe_id){ [parent_event] }
      end
      subject{ Show.new(context).run :id, universe_id: :universe_id }
      it{ subject }
    end

    describe New do
      before do
        expect(repo).to receive(:new_event).with(no_args){ :event }
        expect(repo).to receive(:events).with(universe_id: :universe_id){ :events }
      end
      subject{ New.new(context).run universe_id: :universe_id }
      it{ subject }
    end

    describe Destroy do
      before do
      end
      subject{ Destroy.new(context).run :id }
      before do
        expect(repo).to receive(:delete_event).with(:id){ :event }
      end
      it{ subject }
    end

  end
end
