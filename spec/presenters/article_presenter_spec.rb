require './app/presenters/base_presenter'
require './app/presenters/article_presenter'

describe ArticlePresenter do

  let(:presenter){ ArticlePresenter.new article, view }
  let(:article){ double :article }
  let(:view){ :view }

  subject{ presenter.send function }

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
