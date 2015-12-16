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
      it{ subject }
    end

    describe Destroy do
      subject{ Destroy.new(context).run :id }
      before{ expect(repo).to receive(:delete_participation).with(:id) }
      it{ subject }
    end

  end
end
