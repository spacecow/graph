require 'capybara'
require 'rspec/its'

describe 'events/_event.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/events/_event.html.erb' }
  let(:locals){{ event:event }}
  let(:event){ double :event }

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    expect(event).to receive(:title).with(no_args){ "event_title" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.event' }

  describe "Event title" do
    subject{ page.find '.title' }
    its(:text){ should eq "event_title" }
  end

end
