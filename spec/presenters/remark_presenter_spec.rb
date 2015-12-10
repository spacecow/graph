require './app/presenters/base_presenter'
require './app/presenters/remark_presenter'

describe RemarkPresenter do

  let(:presenter){ RemarkPresenter.new remark, view }
  let(:remark){ double :remark }
  let(:view){ double :view }
  let(:params){ [] }

  subject{ presenter.send function, *params }

  describe "#content" do
    let(:function){ :content }
    before{ expect(remark).to receive(:content).with(no_args){ :content }}
    it{ should be :content }
  end

  describe "#edit_link" do
    let(:function){ :edit_link }
    let(:params){[{ event_id: :event_id }]}
    before do
      expect(view).to receive(:edit_remark_path).with(:id,event_id: :event_id).
        and_return(:path)
      expect(view).to receive(:link_to).with("Edit",:path){ :link }
      expect(remark).to receive(:id).with(no_args){ :id }
    end
    it{ should be :link }
  end

  describe "#delete_link" do
    let(:function){ :delete_link }
    let(:params){[{ event_id: :event_id }]}
    before do
      expect(view).to receive(:link_to).
        with("Delete",:path, method: :delete, data:{confirm:"Are you sure?"}).
        and_return(:link)
      expect(view).to receive(:remark_path).with(:id,event_id: :event_id).
        and_return(:path)
      expect(remark).to receive(:id).with(no_args){ :id }
    end
    it{ should be :link }
  end

end
