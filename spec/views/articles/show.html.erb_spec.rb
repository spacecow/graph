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
                 notes: :notes, note: :note }}
  let(:article){ double :article }
  let(:presenter){ double :presenter }

  before do
    def bind.render template, *opts; end
    def bind.present obj; end
    expect(bind).to receive(:present).with(article).and_yield(presenter)
    expect(article).to receive(:name).with(no_args){ "article_name" }
    expect(presenter).to receive(:relation_groups).with(no_args){ :relation_groups }
    expect(bind).to receive(:render).
      with(partial:"relations/group", collection: :relation_groups, as: :group).
      and_return("render_relation_groups")
    expect(bind).to receive(:render).
      with("relations/form", relation: :relation, targets: :targets).
      and_return("render_relation_form")
    expect(bind).to receive(:render).with(:notes){ "render_notes" }
    expect(bind).to receive(:render).
      with("notes/form", note: :note).and_return("render_note_form")
  end

  subject(:page){ Capybara.string(rendering).find '.article' }

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "article_name" }
  end

  #TODO relations header 
  describe "Relations list" do
    subject{ page.find '.relations' }
    its(:text){ should include "render_relation_groups" }
  end

  #TODO relation form header
  describe "Relation form" do
    subject{ page.find '.relation.new.form' }
    its(:text){ should include "render_relation_form" }
  end

  #TODO note header
  describe "Notes list" do
    subject{ page.find '.notes' }
    its(:text){ should include "render_notes" }
  end

  #TODO note form header
  describe "Note form" do
    subject{ page.find '.note.new.form' }
    its(:text){ should include "render_note_form" }
  end

end
