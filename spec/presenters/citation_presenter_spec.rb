require './app/presenters/base_presenter'
require './app/presenters/citation_presenter'

describe CitationPresenter do

  let(:presenter){ CitationPresenter.new citation, view }
  let(:citation){ double :citation }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#content" do
    let(:function){ :content }
    before{ expect(citation).to receive(:content).with(no_args){ :citation }}
    it{ should be :citation }
  end

  describe "#target_name" do
    let(:function){ :target_name }
    before{ expect(citation).to receive(:target).with(no_args){ target }}
    context "target is nil" do
      let(:target){ nil }
      it{ should be nil }
    end
    context "target exists" do
      let(:target){ :target }
      before do
        expect(view).to receive(:link_to).with(:target_name,:path){ "link" }
        expect(view).to receive(:article_path).with(:target_id){ :path }
        expect(citation).to receive(:target_name).with(no_args){ :target_name }
        expect(citation).to receive(:target_id).with(no_args){ :target_id }
      end
      it{ should eq "link: " }
    end
  end

end
