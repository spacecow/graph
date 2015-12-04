require './app/presenters/base_presenter'
require './app/presenters/article_presenter'

describe ArticlePresenter do

  let(:presenter){ ArticlePresenter.new article, view }
  let(:article){ double :article }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#name" do
    let(:function){ :name }
    before do
      expect(article).to receive(:name).with(no_args){ :name }
      expect(article).to receive(:id).with(no_args){ :id }
      expect(view).to receive(:article_path).with(:id){ :path }
      expect(view).to receive(:link_to).with(:name,:path){ :link }
    end
    it{ should be :link }
  end

  describe "#gender" do
    let(:function){ :gender }
    before do
      expect(article).to receive(:gender).with(no_args){ gender }
    end
    context "Male" do
      let(:gender){ "m" }
      it{ should eq "male" }
    end
    context "Female" do
      let(:gender){ "f" }
      it{ should eq "female" }
    end
    context "Neutral" do
      let(:gender){ "n" }
      it{ should eq "neutral" }
    end
  end

  describe "#relation_groups" do
    let(:function){ :relation_groups }
    let(:relation){ double :relation, type:"Owner", target: :target }
    let(:relation2){ double :relation, type:"Owner", target: :target2 }
    let(:relation3){ double :relation, type:"Owns", target: :target3 }
    before do
      expect(article).to receive(:relations).with(no_args){ relations }
    end
    context "no relations" do
      let(:relations){ [] }
      it{ should eq([]) }
    end
    context "one relation" do
      let(:relations){ [relation] }
      it{ should eq [["Owner", [:target]]] }
    end
    context "two same relation" do
      let(:relations){ [relation,relation2] }
      it{ should eq [["Owner", [:target,:target2]]] }
    end
    context "two different relations" do
      let(:relations){ [relation,relation3] }
      it{ should eq [["Owner", [:target]], ["Owns", [:target3]]] }
    end
  end

end
