require 'rspec/its'
require 'capybara'

class ErbBinding2
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set '@' + key.to_s, value
    end 
  end
end

describe "events/show.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/show.html.erb" }
  let(:locals){{ event:event }}
  let(:event){ double :event }

  before do
    expect(event).to receive(:title).with(no_args){ "header" }
  end

  subject(:page){ Capybara.string(rendering).find '.event' }

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "header" }
  end

end

