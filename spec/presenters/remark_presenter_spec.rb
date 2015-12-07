require './app/presenters/base_presenter'
require './app/presenters/remark_presenter'

describe RemarkPresenter do

  let(:presenter){ RemarkPresenter.new remark, view }
  let(:remark){ double :remark }
  let(:view){ :view }

  subject{ presenter.send function }

  describe "#content" do
    let(:function){ :content }
    before{ expect(remark).to receive(:content).with(no_args){ :content }}
    it{ should be :content }
  end

end
