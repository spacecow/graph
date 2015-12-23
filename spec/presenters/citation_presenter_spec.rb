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

end
