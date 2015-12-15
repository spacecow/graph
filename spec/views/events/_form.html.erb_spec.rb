require 'rspec/its'
require 'capybara'

describe "events/_form.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/_form.html.erb" }
  let(:locals){{ event:event }}
  let(:event){ double :event, id:event_id }
  let(:builder){ double :builder }

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    def bind.form_for obj, *opts; end
    def bind.event_path id; raise NotImplementedError end
    def bind.events_path; raise NotImplementedError end
    expect(bind).to receive(:form_for).with(event,url: :path,method:mode).and_yield builder
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
  end

  subject(:page){ Capybara.string(rendering) }

  context "New Event" do
    let(:event_id){ nil }
    let(:mode){ :post }

    before do
      expect(bind).to receive(:events_path).with(no_args){ :path }
      expect(builder).to receive(:submit).with("Create"){ "submit" }
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

  context "Existing Event" do
    let(:event_id){ :id }
    let(:mode){ :put }

    before do
      expect(bind).to receive(:event_path).with(:id){ :path }
      expect(builder).to receive(:submit).with("Update"){ "submit" }
    end

    describe "Form button" do
      its(:text){ should include "submit" }
    end
  end

end

