require 'rspec/its'
require 'capybara'

describe 'remarks/_remark.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/remarks/_remark.html.erb' }
  let(:locals){{ remark: :remark }}
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
  end

  subject(:page){ Capybara.string(rendering).find 'li.remark' }

  describe "Remark content" do
    its(:text){ should include "content" }
  end

end
