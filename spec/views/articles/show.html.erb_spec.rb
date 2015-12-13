require 'capybara'
require 'rspec/its'

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
  let(:locals){{ article:article, relation: :relation, targets: :targets,
                 notes: :notes, note: :note, events:events,
                 relation_types: :relation_types, relations: :relations }}
  let(:article){ double :article }
  let(:presenter){ double :presenter }
  let(:events){ :events }

  before do
    def bind.render template, *opts; end
    def bind.present obj; end
    expect(bind).to receive(:present).with(article).and_yield(presenter)
    expect(article).to receive(:name).with(no_args){ "article_name" }
    expect(bind).to receive(:render).with(:relations){ "render_relations" }
    expect(bind).to receive(:render).
      with("relations/form", relation: :relation, targets: :targets,
            relation_types: :relation_types).and_return("render_relation_form")
    expect(bind).to receive(:render).
      with(:notes, tag_id:nil){ "render_notes" }
    expect(bind).to receive(:render).with(:events){ "render_events" } unless events.empty?
    expect(bind).to receive(:render).
      with("notes/form", note: :note).and_return("render_note_form")
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

  describe "Events section" do
    context "no events exist" do
      let(:events){ [] }
      it{ should_not have_selector '.events.list'  }
    end
    describe "Events header" do
      subject{ page.find '.events.list h2' }
      its(:text){ should eq "Events" }
    end
    describe "Events list" do
      subject{ page.find '.events.list ul.events' }
      its(:text){ should eq "render_events" }
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

  #TODO note form header
  describe "Note form" do
    subject{ page.find '.note.new.form' }
    its(:text){ should include "render_note_form" }
  end

end
