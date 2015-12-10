require 'rspec/its'
require 'capybara'

describe 'remarks/_remark.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/remarks/_remark.html.erb' }
  let(:locals){{ remark: :remark, event_id: :event_id }}
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
    expect(bind).to receive(:present).with(:remark).and_yield(presenter)
    expect(presenter).to receive(:content).with(no_args){ "content" }
    expect(presenter).to receive(:edit_link).with(event_id: :event_id).
      and_return("edit_remark_link")
    expect(presenter).to receive(:delete_link).with(event_id: :event_id).
      and_return("delete_remark_link")
  end

  subject(:page){ Capybara.string(rendering).find 'li.remark' }

  describe "Remark content" do
    subject{ page.find '.content' }
    its(:text){ should eq "content" }
  end

  describe 'actions' do
    subject(:actions){ page.find '.actions' }
    describe 'Edit' do
      subject{ actions.find '.edit' }
      its(:text){ is_expected.to eq "edit_remark_link" }
    end
    describe 'Delete' do
      subject{ actions.find '.delete' }
      its(:text){ is_expected.to eq "delete_remark_link" }
    end
  end

end
