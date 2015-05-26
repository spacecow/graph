require 'view_helper'

describe "universes/show.html.erb" do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/universes/show.html.erb' }
  let(:locals){ {} }
  let(:universe){ double :universe, title:'The Malazan Empire' }
  let(:articles){ [] }

  before do
    def erb_bindings.render a; end
    def erb_bindings.new_article_path; end
    erb_bindings.instance_variable_set "@universe", universe
    erb_bindings.instance_variable_set "@articles", articles
  end

  subject(:div){ Capybara.string(rendering).find '.universe' }

  describe "header" do
    subject{ div.find 'h2' }
    its(:text){ is_expected.to eq 'The Malazan Empire' }
  end

  describe "articles secion" do
    it{ is_expected.to have_selector 'ul.articles' }
    context "no articles" do
      before{ expect(erb_bindings).not_to receive(:render) }
      it("no article is being rendered"){ subject }
    end

    context "one article" do
      let(:articles){ [:article] }
      describe "rendered universes" do
        before{ expect(erb_bindings).to receive(:render).once }
        it("one article is being rendered"){ subject }
      end
    end

    context "two articles" do
      let(:articles){ [:article1, :article2] }
      describe "rendered universes" do
        before{ expect(erb_bindings).to receive(:render).twice }
        it("two articles are being rendered"){ subject }
      end
    end
  end

  describe 'actions section' do
    subject(:ul){ div.find 'ul.actions' }
    before{ expect(erb_bindings).to receive(:new_article_path){ "path" }}
    describe 'new action' do
      subject{ ul.find('li.action.new a') }
      its(:text){ is_expected.to eq 'New Article' }
      its([:href]){ should eq 'path' }
    end
  end

end
