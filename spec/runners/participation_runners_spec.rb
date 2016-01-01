unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/participation_runners'

module ParticipationRunners

  describe ParticipationRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }

    describe Create do
      before do
        expect(repo).to receive(:new_participation).
          with(:params){ :participation }
        expect(repo).to receive(:save_participation).
          with(:participation){ :participation }
      end
      subject{ Create.new(context).run :params }
      it{ should eq [:participation] }
    end

    describe Edit do
      subject{ Edit.new(context).run :id, universe_id: :universe_id }
      before do
        expect(repo).to receive(:participation).with(:id){ :participation }
        expect(repo).to receive(:articles).
          with(universe_id: :universe_id){ :articles }
      end
      it{ should eq [:participation,:articles] }
    end

    describe Update do
      subject{ Update.new(context).run :id, :params }
      before do
        expect(repo).to receive(:update_participation).with(:id,:params)
      end
      it{ should eq [] }
    end

    describe Destroy do
      subject{ Destroy.new(context).run :id }
      before{ expect(repo).to receive(:delete_participation).with(:id) }
      it{ should eq [] }
    end

  end
end
