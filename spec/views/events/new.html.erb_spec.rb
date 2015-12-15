require 'rspec/its'
require 'capybara'

describe "events/new.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/new.html.erb" }
  let(:locals){{ event: :event }}

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
    end
    def bind.render template, *locals; raise NotImplementedError end
    expect(bind).to receive(:render).with("form",event: :event){ "render_event_form" }
  end

  subject(:page){ Capybara.string(rendering).find '.event.new.form' }

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "New Event" }
  end

  describe "Form title" do
    its(:text){ should include "render_event_form" }
  end

end

