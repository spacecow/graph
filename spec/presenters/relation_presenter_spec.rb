require 'active_support/core_ext/string/inflections'
require './app/presenters/base_presenter'
require './app/presenters/relation_presenter'

describe RelationPresenter do

  let(:presenter){ RelationPresenter.new relation, view }
  let(:relation){ double :relation }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#target" do
    let(:function){ :target }
    before do
      expect(view).to receive(:article_path).with(:target_id){ :path }
      expect(view).to receive(:link_to).with(:target_name,:path){ :link }
      expect(relation).to receive(:target_name).with(no_args){ :target_name }
      expect(relation).to receive(:target_id).with(no_args){ :target_id }
    end
    it{ subject }
  end

  describe "#title" do
    let(:function){ :title }
    before{ expect(relation).to receive(:type).with(no_args){ "RightHand" }}
    it{ should eq "Right hand" }
  end

  describe "#type" do
    let(:function){ :type }
    before do
      expect(view).to receive(:relation_path).with(:id){ :path }
      expect(view).to receive(:link_to).with(:title,:path){ :link }
      expect(relation).to receive(:id).with(no_args){ :id }
      expect(presenter).to receive(:title).with(no_args){ :title }
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
