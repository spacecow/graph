require 'rspec/its'
require 'capybara'

describe 'relations/_relation.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= content/,'<% content') }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/relations/_relation.html.erb' }
  let(:locals){{ relation:relation }}
  let(:relation){ double :relation }
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
    expect(bind).to receive(:present).with(relation).and_yield(presenter)
    expect(bind).to receive(:content_tag).
      with(:span, class:%w(target male).join(" ")).and_yield
    expect(presenter).to receive(:type).with(no_args){ "type" }
    expect(presenter).to receive(:references_comments).with(no_args){ "comments" }
    expect(presenter).to receive(:target).with(no_args){ "target" }
    expect(presenter).to receive(:gender).with(no_args){ "male" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.relation' }

  describe "Target name" do
    its(:text){ should include "target" }
  end

  describe "References comments" do
    subject{ page.find '.references.comments' }
    its(:text){ should eq "comments" }
  end

  describe "Relation type" do
    subject{ page.find '.type' }
    its(:text){ should eq "type" }
  end

end
