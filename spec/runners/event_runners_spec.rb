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
        expect(repo).to receive(:events).with(universe_id: :universe_id).
          and_return(:all_events)
        expect(repo).to receive(:articles).with(universe_id: :universe_id).
          and_return(:all_articles)
        expect(event).to receive(:available_events).with(:all_events){ :events }
        expect(event).to receive(:available_articles).with(:all_articles){ :articles }
        expect(repo).to receive(:new_participation).with(event_id: :event_id).
          and_return(:participation)
        expect(event).to receive(:participations).with(no_args){ :participations }
        expect(repo).to receive(:new_step).with(child_id: :event_id){ :parent_step }
        expect(event).to receive(:notes).with(no_args){ :notes }
        expect(repo).to receive(:new_note).with(event_id: :event_id){ :note }
        expect(repo).to receive(:new_mention).with(origin_id: :event_id){ :mention }
      end
      subject{ Show.new(context).run :id, universe_id: :universe_id }
      it{ should eq([event, :events, :articles, :participation, :participations,
        :parent_step, :notes, :note, :mention]) }
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
