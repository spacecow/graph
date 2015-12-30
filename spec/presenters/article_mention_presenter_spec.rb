require './app/presenters/base_presenter'
require './app/presenters/article_mention_presenter'
require 'active_support/core_ext/string/output_safety'
require 'active_support/core_ext/object/blank'

describe ArticleMentionPresenter do

  let(:presenter){ ArticleMentionPresenter.new mdl, view }
  let(:mdl){ double :mdl }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#content" do
    let(:function){ :content }
    before do
      expect(mdl).to receive(:content).with(no_args){ content }
    end
    context "Content is nil" do
      let(:content){ nil }
      it{ should be nil }
    end
    context "Content has value" do
      before do
        expect(mdl).to receive(:id).with(no_args){ :id }
        expect(view).to receive(:edit_article_mention_path).with(:id){ :path }
      end
      context "Content is non-blank" do
        let(:content){ :content }
        before{ expect(view).to receive(:link_to).with(:content,:path){ "link" }}
        it{ should eq " - link" }
      end
      context "Content is blank" do
        let(:content){ "" }
        before{ expect(view).to receive(:link_to).with("Edit",:path){ "link" }}
        it{ should eq " - link" }
      end
    end
  end

end
