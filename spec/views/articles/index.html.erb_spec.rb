require 'view_helper'
require 'capybara'

describe "articles/index.html.erb" do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/articles/index.html.erb' }
  let(:locals){ {} }
  let(:articles){ [] }

  before do
    def erb_bindings.render a; "<li></li>" end
    def erb_bindings.new_article_path; end
    erb_bindings.instance_variable_set '@articles', articles
  end

  describe 'articles secion' do
    subject{ Capybara.string(rendering).all 'ul.articles li' }

    context "no articles" do
      describe "rendered universes" do
        its(:count){ is_expected.to be 0 }
      end
    end

    context "one article" do
      let(:articles){ [:article] }
      describe "rendered universes" do
        its(:count){ is_expected.to be 1 }
      end
    end

    context "two articles" do
      let(:articles){ [:article1, :article2] }
      describe "rendered universes" do
        its(:count){ is_expected.to be 2 }
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
