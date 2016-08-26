require 'capybara'
require 'rspec/its'
require 'active_support/core_ext/object/blank.rb'

class ErbBinding2
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set '@' + key.to_s, value
    end 
  end
end

describe "articles/show.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/articles/show.html.erb" }
  let(:locals){{ article:article, relation: :relation, article_tags: :article_tags,
    notes: :notes, note: :note, events:events, 
    relation_types: :relation_types, relations: :relations, tagging: :tagging,
    tags: :tags, citation: :citation, citation_targets: :citation_targets }}
  let(:article){ double :article }
  let(:presenter){ double :presenter }
  let(:events){ :events }

  before do
    def bind.render template, *opts; end
    def bind.present obj; end
    expect(bind).to receive(:present).with(article).and_yield(presenter)
    expect(article).to receive(:name).with(no_args){ "article_name" }
    expect(article).to receive(:id).with(no_args){ :article_id }
    expect(article).to receive(:target_ids).with(no_args){ :target_ids }
    expect(article).to receive(:citations).with(no_args).
      at_least(1){ [:citation] }
    expect(article).to receive(:mentions).with(no_args).at_least(1){ :mentions }
    expect(article).to receive(:inverse_citations).with(no_args){ [:inverse_citation] }
    expect(bind).to receive(:render).with(:relations){ "render_relations" }
    expect(bind).to receive(:render).with(:article_tags){ "render_article_tags" }
    expect(bind).to receive(:render).with(partial:"citations/inverse_citation",
      collection:[:inverse_citation], as: :citation){ "render_inverse_mentions" }
    expect(bind).to receive(:render).with(
      partial:"article_mentions/inverse_article_mention",
      collection: :mentions, as: :article_mention){ "render_mentions" }
    expect(bind).to receive(:render).
      with("relations/form", relation: :relation,
            relation_types: :relation_types, article_id: :article_id,
            target_ids: :target_ids).and_return("render_relation_form")
    expect(bind).to receive(:render).
      with("citations/form", citation: :citation, targets: :citation_targets).
      and_return("render_citation_form")
    expect(bind).to receive(:render).
      with(:notes, tag_id:nil){ "render_notes" }
    expect(bind).to receive(:render).with(:events){ "render_events" } unless events.empty?
    expect(bind).to receive(:render).with([:citation]){ "render_citations" }
    expect(bind).to receive(:render).
      with("notes/form", note: :note).and_return("render_note_form")
    expect(bind).to receive(:render).
      with("taggings/form", tagging: :tagging, tags: :tags).
      and_return("render_tagging_form")
  end

  subject(:page){ Capybara.string(rendering).find '.article' }

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "article_name" }
  end

  #TODO note list header
  describe "Note list" do
    subject{ page.find '.notes' }
    its(:text){ should include "render_notes" }
  end

  describe "Tag list" do
    subject{ page.find '.tags' }
    its(:text){ should include "render_article_tags" }
  end

  describe "Events section" do
    describe "Events header" do
      subject{ page.all('.events.list h2').first }
      its(:text){ should eq "Events" }
    end
    describe "Events list" do
      subject{ page.all('.events.list ul.events').first }
      its(:text){ should eq "render_events" }
    end
  end

  describe "Mention section" do
    describe "Mention header" do
      subject{ page.find '.mentions.events.list h2' }
      its(:text){ should eq "Mentions" }
    end
    describe "Events list" do
      subject{ page.find '.mentions.events.list ul.events' }
      its(:text){ should include "render_mentions" }
    end
  end

  #TODO relations header 
  describe "Relation list" do
    subject(:div){ page.find '.relations.list' }
    describe "Header" do
      subject{ div.find 'h2' }
      its(:text){ should eq "Relations" }
    end
    describe "List" do
      subject{ page.find 'ul.relations' }
      its(:text){ should include "render_relations" }
    end

  end

  #TODO relation form header
  describe "Relation form" do
    subject{ page.find '.relation.new.form' }
    its(:text){ should include "render_relation_form" }
  end

  #TODO relation form header
  describe "Citation form" do
    subject{ page.find '.citation.new.form' }
    its(:text){ should include "render_citation_form" }
  end


  #TODO note form header
  describe "Note form" do
    subject{ page.find '.note.new.form' }
    its(:text){ should include "render_note_form" }
  end

  #TODO tagging form header
  describe "Tagging form" do
    subject{ page.find '.tagging.new.form' }
    its(:text){ should include "render_tagging_form" }
  end


end
