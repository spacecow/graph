require 'rspec/its'
require 'capybara'

describe "events/new.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/new.html.erb" }
  let(:locals){{ event: :event, events: :events }}
  let(:builder){ double :builder }

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
    end
    def bind.form_for obj; end
    expect(bind).to receive(:form_for).with(:event).and_yield builder
    expect(builder).to receive(:label).with(:title){ "label_title" }
    expect(builder).to receive(:text_field).with(:title){ "text_title" }
    expect(builder).to receive(:label).
      with(:parent_tokens, "Parents"){ "label_parents" }
    expect(builder).to receive(:text_field).
      with(:parent_tokens){ "text_parent_tokens" }
    expect(builder).to receive(:label).
      with(:child_tokens, "Children"){ "label_children" }
    expect(builder).to receive(:text_field).
      with(:child_tokens){ "text_child_tokens" }
    expect(builder).to receive(:submit).with(no_args){ "submit" }
  end

  subject(:page){ Capybara.string(rendering).find '.event.new.form' }

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "New Event" }
  end

  describe "Form title" do
    subject{ page.find 'div.title' }
    its(:text){ should match /label_title\s*text_title/m }
  end

  describe "Form parents" do
    subject{ page.find 'div.parents' }
    its(:text){ should match /label_parents\s*text_parent_tokens/m }
  end

  describe "Form children" do
    subject{ page.find 'div.children' }
    its(:text){ should match /label_children\s*text_child_tokens/m }
  end

  describe "Form button" do
    its(:text){ should include "submit" }
  end

end

