require 'rspec/its'
require 'capybara'

describe 'articles/_article.html.erb' do
  
  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= content/,'<% content') }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/articles/_article.html.erb' }
  let(:locals){{ article: :article }}
  let(:presenter){ double :presenter }

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    def bind.present obj; raise NotImplementedError end
    def bind.content_tag tag, *opts; raise NotImplementedError end
    #def bind.article_path id; end
    #expect(article).to receive(:id){ 666 }
    #expect(article).to receive(:name){ 'Kelsier' }
    #expect(bind).to receive(:article_path).with(666){ "path" }
    expect(bind).to receive(:present).with(:article).and_yield(presenter)
    expect(bind).to receive(:content_tag).
      with(:li, class:%w(article male).join(" ")).and_yield
    expect(presenter).to receive(:gender).with(no_args){ "male" }
    expect(presenter).to receive(:name).with(no_args){ "name" }
  end

  subject(:page){ Capybara.string rendering }

  describe 'name' do
    subject(:name){ page.find '.name' }
    its(:text){ is_expected.to include "name" } 
  end

end
