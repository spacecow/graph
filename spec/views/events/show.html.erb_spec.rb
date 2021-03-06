require 'rspec/its'
require 'capybara'
require 'active_support/core_ext/object/blank'

describe "events/show.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/events/show.html.erb" }
  let(:locals){{ event:event, participation: :participation, articles: :articles,
    parent_step: :parent_step, notes: :notes, note: :note, events: :events,
    participations: :participations,  mention: :mention,
    article_mention: :article_mention }}
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
    expect(bind).to receive(:render).with(:mentions){ "render_mentions" }
    expect(bind).to receive(:render).with(:article_mentions).
      and_return("render_article_mentions")
    expect(bind).to receive(:render).with(partial:"mentions/inverse_mention",
      collection: :inverse_mentions, as: :mention){ "render_inverse_mentions" }
    expect(bind).to receive(:render).
      with(:notes, tag_id:nil){ "render_notes" }
    expect(bind).to receive(:render).with(:children){ "render_children" }
    expect(bind).to receive(:render).with(:participations){ :render_participations }
    expect(bind).to receive(:render).
      with("steps/form", step: :parent_step, parents: :events).
      and_return("step_form")
    expect(bind).to receive(:render).with("notes/form", note: :note).
      and_return("note_form")
    expect(bind).to receive(:render).
      with("mentions/form", mention: :mention, mentions: :events).
      and_return("mention_form")
    expect(bind).to receive(:render).
      with("article_mentions/form", mention: :article_mention, mentions: :articles).
      and_return("article_mention_form")
    expect(bind).to receive(:render).
      with("participations/form", participation: :participation, articles: :articles).
      and_return("participation_form")
    expect(event).to receive(:title).with(no_args){ "header" }
    expect(event).to receive(:parents).with(no_args){ :parents }
    expect(event).to receive(:mentions).with(no_args).twice{ :mentions }
    expect(event).to receive(:article_mentions).with(no_args).
      twice{ :article_mentions }
    expect(event).to receive(:inverse_mentions).with(no_args).
      and_return(:inverse_mentions)
    expect(event).to receive(:children).with(no_args){ :children }
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

  describe "Mention list" do
    subject{ page.find 'ul.mentions.events.direct' }
    its(:text){ should eq "render_mentions" }
  end

  describe "Inverse mention list" do
    subject{ page.find 'ul.mentions.events.inverse' }
    its(:text){ should include "render_inverse_mentions" }
  end

  describe "Article mention list" do
    subject{ page.find 'ul.mentions.articles.direct' }
    its(:text){ should include "render_article_mentions" }
  end

  describe "Participant section" do
    subject(:div){ page.find '.event .participations.list' }
    describe "Participant header" do
      subject{ div.find 'h2' }
      its(:text){ should eq "Participants" }
    end
    describe "Participant list" do
      subject{ div.find 'ul.participations' }
      its(:text){ should eq "render_participations" }
    end
  end

  describe "Notes section" do
    subject(:div){ page.find '.event .notes.list' }
    describe "Header" do
      subject{ div.find 'h2' }
      its(:text){ should eq "Notes" }
    end
    describe "List" do
      subject{ div.find 'ul.notes' }
      its(:text){ should eq "render_notes" }
    end
  end

  describe "Participation form" do
    subject{ page.find '.participation.new.form' }
    its(:text){ should include "participation_form" }
  end

  describe "Note form" do
    subject{ page.find '.note.new.form' }
    its(:text){ should include "note_form" }
  end

  describe "Mention form" do
    subject{ page.find '.mention.event.new.form' }
    its(:text){ should include "mention_form" }
  end

  describe "Article mention form" do
    subject{ page.find '.mention.article.new.form' }
    its(:text){ should include "article_mention_form" }
  end

  describe "Step form" do
    subject{ page.find '.step.new.form' }
    its(:text){ should include "step_form" }
  end

end
