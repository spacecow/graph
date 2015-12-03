require './app/presenters/base_presenter'
require './app/presenters/relation_presenter'

describe RelationPresenter do

  let(:presenter){ RelationPresenter.new relation, view }
  let(:relation){ double :relation }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#type" do
    let(:function){ :type }
    before do
      expect(view).to receive(:relation_path).with(:id){ :path }
      expect(view).to receive(:link_to).with(:type,:path){ :link }
      expect(relation).to receive(:type).with(no_args){ :type }
      expect(relation).to receive(:id).with(no_args){ :id }
    end
    it{ should be :link }
  end

  describe "#references_comments" do
    let(:function){ :references_comments }
    let(:reference){ double :reference }
    before do
      expect(relation).to receive(:references).with(no_args){ [reference] }
      expect(reference).to receive(:comment).with(no_args){ "comment" }
    end
    it{ should eq "comment" }
  end

end
