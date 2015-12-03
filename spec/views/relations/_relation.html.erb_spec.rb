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

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    expect(relation).to receive(:type).with(no_args){ "type" }
    expect(relation).to receive(:target_name).with(no_args){ "target_name" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.relation' }

  describe "Relation type" do
    subject{ page.find '.type' }
    its(:text){ should eq "type" }
  end

  describe "Target name" do
    subject{ page.find '.target.name' }
    its(:text){ should eq "target_name" }
  end

end
