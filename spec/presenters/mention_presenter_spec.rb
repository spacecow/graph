require './app/presenters/base_presenter'
require './app/presenters/mention_presenter'

describe MentionPresenter do

  let(:presenter){ MentionPresenter.new mention, view }
  let(:mention){ double :mention }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#target_title" do
    let(:function){ :target_title }
    before do
      expect(view).to receive(:event_path).with(:id){ :path }
      expect(view).to receive(:link_to).with(:title,:path){ :link }
      expect(mention).to receive(:target_title).with(no_args){ :title }
      expect(mention).to receive(:target_id).with(no_args){ :id }
    end
    it{ should be :link }
  end

end
