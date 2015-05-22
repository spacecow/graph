require 'view_helper'
require 'capybara'

describe 'articles/_article.html.erb' do
  
  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/articles/_article.html.erb' }
  let(:locals){ {article:article} }

  let(:article){ double :article, name:'Kelsier' }

  describe 'rendered article' do
    subject(:div){ Capybara.string(rendering).find 'div.article' }
    describe 'name' do
      subject{ div.find '.name' }
      its(:text){ is_expected.to eq 'Kelsier' } 
    end
  end

end
