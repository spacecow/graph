require './app/presenters/base_presenter'
require './app/presenters/remark_presenter'

describe RemarkPresenter do

  let(:presenter){ RemarkPresenter.new remark, view }
  let(:remark){ double :remark }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#content" do
    let(:function){ :content }
    before{ expect(remark).to receive(:content).with(no_args){ :content }}
    it{ should be :content }
  end

  describe "#edit_link" do
    let(:function){ :edit_link }
    before do
      expect(view).to receive(:edit_remark_path).with(:id){ :path }
      expect(view).to receive(:link_to).with("Edit",:path){ :link }
      expect(remark).to receive(:id).with(no_args){ :id }
    end
    it{ should be :link }
  end

end
