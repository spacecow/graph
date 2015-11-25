require 'view_helper'

describe 'articles/_article.html.erb' do
  
  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/articles/_article.html.erb' }
  let(:locals){{ article:article }}
  let(:article){ double :article }

  before do
    def bind.article_path id; end
    expect(article).to receive(:id){ 666 }
    expect(article).to receive(:name){ 'Kelsier' }
    expect(bind).to receive(:article_path).with(666){ "path" }
  end

  subject(:li){ Capybara.string(rendering).find 'li.article' }

  describe 'name' do
    subject(:name){ li.find '.name' }
    its(:text){ is_expected.to include 'Kelsier' } 

    describe "link" do
      subject{ name.find 'a' }
      its(:text){ is_expected.to eq 'Kelsier' }
      its([:href]){ is_expected.to eq "path" }
    end
  end

end
