require 'rspec/its'
require 'capybara'

describe 'relations/_relation.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
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
    expect(bind).to receive(:present).with(relation).and_yield(presenter)
    expect(presenter).to receive(:type).with(no_args){ "type" }
    expect(presenter).to receive(:references_comments).with(no_args){ "comments" }
    expect(presenter).to receive(:target).with(no_args){ "target" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.relation' }

  describe "Relation type" do
    subject{ page.find '.type' }
    its(:text){ should eq "type" }
  end

  describe "Target name" do
    subject{ page.find '.target' }
    its(:text){ should eq "target" }
  end

  describe "References comments" do
    subject{ page.find '.references.comments' }
    its(:text){ should eq "comments" }
  end


end
