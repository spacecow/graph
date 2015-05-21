require 'view_helper'
require 'capybara'

describe 'articles/index.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/articles/index.html.erb' }
  let(:locals){ {} }
  let(:articles){ [] }

  before do
    def erb_bindings.render a; end
    def erb_bindings.new_article_path; end
    erb_bindings.instance_variable_set "@articles", articles
  end

  subject{ rendering }

  describe 'articles secion' do
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
    subject(:ul){ Capybara.string(rendering).find 'ul.actions' }
    describe 'new action' do
      before{ expect(erb_bindings).to receive(:new_article_path){ "path" }}
      subject{ ul.find 'li.action.new a' }
      its(:text){ is_expected.to eq 'New Article' }
      its([:href]){ is_expected.to eq "path" }
    end
  end

end
