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
    def bind.event_path id; raise NotImplementedError end
    def bind.link_to s, path, *opts; raise NotImplementedError end
    expect(event).to receive(:title).with(no_args){ :title }
    expect(event).to receive(:id).with(no_args).at_least(1){ :id }
    expect(bind).to receive(:event_path).with(:id).at_least(1){ :path }
    expect(bind).to receive(:link_to).with(:title, :path){ "show_event_link" }
    expect(bind).to receive(:link_to).
      with("Delete", :path, method: :delete, data:{confirm:"Are you sure?"}).
      and_return("delete_event_link")
  end

  subject(:page){ Capybara.string(rendering).find 'li.event' }

  describe "Event title" do
    subject{ page.find '.title' }
    its(:text){ should eq "show_event_link" }
  end

  describe "Event action" do
    subject(:actions){ page.find '.actions' }
    describe "Delete" do
      subject{ actions.find '.delete' }
      its(:text){ should eq "delete_event_link" }
    end
  end

end
