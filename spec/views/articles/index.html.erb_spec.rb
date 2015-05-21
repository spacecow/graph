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

  before do
    def erb_bindings.render mdl; mdl end
    erb_bindings.instance_variable_set "@articles", articles
  end

  subject{ rendering }

  describe 'articles secion' do
    context "no articles" do
      let(:articles){ [] }
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
end
