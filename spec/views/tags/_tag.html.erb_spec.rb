require 'rspec/its'
require 'capybara'

describe 'tags/_tag.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/tags/_tag.html.erb' }
  let(:locals){{ tag: :tag }}
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
    expect(bind).to receive(:present).with(:tag).and_yield(presenter)
    expect(presenter).to receive(:title).with(no_args){ "tag_title" }
    expect(presenter).to receive(:delete_link).with(no_args){ "tag_delete_link" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.tag' }

  describe "Tag title" do
    subject{ page.find '.title' }
    its(:text){ should eq "tag_title" }
  end

  describe "Tag delete link" do
    subject{ page.find '.actions .delete' }
    its(:text){ should eq "tag_delete_link" }
  end

end
