require 'rspec/its'
require 'capybara'

describe "events/show.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/show.html.erb" }
  let(:locals){{ event:event, participation: :participation, articles: :articles,
    parent_step: :parent_step, parents: :parents, remarks: :remarks,
    remark: :remark }}
  let(:event){ double :event, id: :event_id }
  let(:presenter){ double :presenter }

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
      def present obj; raise NotImplementedError end
      def render obj, locals={}; raise NotImplementedError end
    end
    expect(bind).to receive(:present).with(event).and_yield(presenter)
    expect(bind).to receive(:render).with(:parents){ "render_parents" }
    expect(bind).to receive(:render).
      with(:remarks, event_id: :event_id){ "render_remarks" }
    expect(bind).to receive(:render).with(:children){ "render_children" }
    expect(bind).to receive(:render).with(:participants){ :render_participants }
    expect(bind).to receive(:render).
      with("steps/form", step: :parent_step, parents: :parents).
      and_return("step_form")
    expect(bind).to receive(:render).
      with("remarks/form", remark: :remark, event_id: :event_id).
      and_return("remark_form")
    expect(bind).to receive(:render).
      with("participations/form", participation: :participation, articles: :articles).
      and_return("participation_form")
    expect(event).to receive(:title).with(no_args){ "header" }
    expect(event).to receive(:parents).with(no_args){ :parents }
    expect(event).to receive(:children).with(no_args){ :children }
    expect(event).to receive(:participants).with(no_args){ :participants }
  end

  subject(:page){ Capybara.string(rendering) }

  describe "Tag header" do
    subject{ page.find '.event h1' }
    its(:text){ should eq "header" }
  end

  describe "Parents list" do
    subject{ page.find 'ul.parents' }
    its(:text){ should eq "render_parents" }
  end

  describe "Children list" do
    subject{ page.find 'ul.children' }
    its(:text){ should eq "render_children" }
  end

  describe "Participant section" do
    subject(:div){ page.find '.event .participants.list' }
    describe "Participant header" do
      subject{ div.find 'h2' }
      its(:text){ should eq "Participants" }
    end
    describe "Participant list" do
      subject{ div.find 'ul.participants' }
      its(:text){ should eq "render_participants" }
    end
  end

  describe "Remarks section" do
    subject(:div){ page.find '.event .remarks.list' }
    describe "Header" do
      subject{ div.find 'h2' }
      its(:text){ should eq "Remarks" }
    end
    describe "List" do
      subject{ div.find 'ul.remarks' }
      its(:text){ should eq "render_remarks" }
    end
  end

  describe "Participation form" do
    subject{ page.find '.participation.new.form' }
    its(:text){ should include "participation_form" }
  end

  describe "Remark form" do
    subject{ page.find '.remark.new.form' }
    its(:text){ should include "remark_form" }
  end

  describe "Step form" do
    subject{ page.find '.step.new.form' }
    its(:text){ should include "step_form" }
  end

end
