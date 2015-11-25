require 'capybara'
require 'rspec/its'

describe "events/index.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/index.html.erb" }
  let(:locals){{ events: :events }}
  
  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
      def render obj; end
    end
    expect(bind).to receive(:render).with(:events){ "render_events" }
  end

  subject(:page){ Capybara.string(rendering).find '.events.list' }
  
  describe "Event header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "Events" }
  end

  describe "List events" do
    subject{ page.find 'ul' }
    its(:text){ should eq "render_events" }
  end

end
