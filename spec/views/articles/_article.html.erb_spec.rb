require 'rspec/its'
require 'capybara'

describe "articles/_article.html.erb" do
  
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
    expect(bind).to receive(:present).with(:article).and_yield(presenter)
    expect(bind).to receive(:content_tag).
      with(:span, class:%w(name male).join(" ")).and_yield
    expect(presenter).to receive(:gender).with(no_args){ "male" }
    expect(presenter).to receive(:name).with(no_args){ "name" }
    expect(presenter).to receive(:type).with(no_args){ "type" }
    expect(presenter).to receive(:edit_link).with(no_args){ "edit_link" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.article' }

  describe "Name" do
    its(:text){ is_expected.to include "name" } 
  end

  describe "Type" do
    subject{ page.find '.type' }
    its(:text){ is_expected.to eq "type" } 
  end

  describe "Edit link" do
    subject{ page.find '.actions .edit' }
    its(:text){ is_expected.to eq "edit_link" } 
  end

end
