require 'rspec/its'
require 'capybara'

describe "mentions/_mention.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file.sub(/<%= content/,'<% content') }
  let(:file){ File.read filepath }

  let(:filepath){ './app/views/mentions/_mention.html.erb' }
  let(:locals){{ mention: :mention }}
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
    expect(bind).to receive(:present).with(:mention).and_yield(presenter)
    expect(presenter).to receive(:target_title).with(no_args){ "target_title" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.mention' }

  describe "Target title" do
    its(:text){ is_expected.to include "target_title" } 
  end

end
