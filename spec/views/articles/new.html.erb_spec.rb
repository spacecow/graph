require 'view_helper'
require 'capybara'

describe 'articles/new.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/articles/new.html.erb' }
  let(:locals){ {} }

  before do
    def erb_bindings.render a, b; end
    expect(erb_bindings).to receive(:render).with('form', article: :article)
    erb_bindings.instance_eval '@article = :article' 
  end

  subject(:div){ Capybara.string(rendering).find '.article.new.form' }

  describe "header" do
    subject{ div.find 'h2' }
    its(:text){ is_expected.to eq 'New Article' }
  end

end
