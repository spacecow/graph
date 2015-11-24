require 'rspec/its'
require 'capybara'

class ErbBinding2
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set '@' + key.to_s, value
    end 
  end
  def present obj; raise NotImplementedError end
  def render obj, locals={}; raise NotImplementedError end
end

describe "events/show.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/show.html.erb" }
  let(:locals){{ event:event, participation: :participation, articles: :articles }}
  let(:event){ double :event }
  let(:presenter){ double :presenter }

  before do
    expect(bind).to receive(:present).with(event).and_yield(presenter)
    expect(bind).to receive(:render).with(:participants){ :participations }
    expect(bind).to receive(:render).
      with("participations/form", participation: :participation, articles: :articles).
      and_return(:participations)
    expect(presenter).to receive(:parent).with(no_args){ "parent" }
    expect(event).to receive(:title).with(no_args){ "header" }
    expect(event).to receive(:participants).with(no_args){ :participants }
  end

  subject(:page){ Capybara.string(rendering).find '.event' }

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "header" }
  end

  describe "Parent section" do
    subject{ page.find '.parent' }
    its(:text){ should eq "parent" }
  end

end

