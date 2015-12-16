require './app/presenters/base_presenter'
require './app/presenters/participation_presenter'

describe ParticipationPresenter do

  let(:presenter){ ParticipationPresenter.new participation, view }
  let(:participation){ double :participation }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#delete_link" do
    let(:function){ :delete_link }
    before do
      expect(view).to receive(:link_to).
        with("Delete",:path,method: :delete, data:{confirm:"Are you sure?"}).
        and_return(:link)
      expect(view).to receive(:participation_path).with(:id){ :path }
      expect(participation).to receive(:id).with(no_args){ :id }
    end
    it{ should be :link }
  end

end
