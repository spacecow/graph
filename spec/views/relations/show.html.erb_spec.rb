require 'view_helper'

describe 'notes/edit.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file.gsub(/<%= content/,'<% content') }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding2.new locals }

  let(:filepath){ './app/views/relations/show.html.erb' }
  let(:locals){{ relation:relation, references: :references,
    reference: :reference }}
  let(:relation){ double :relation }
  let(:presenter){ double :presenter }

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end
      end
    end
    def bind.present obj; raise NotImplementedError end
    def bind.content_tag tag, *opts; raise NotImplementedError end
    def bind.render obj, *opts; raise NotImplementedError end
    expect(bind).to receive(:present).with(relation).and_yield(presenter)
    expect(bind).to receive(:content_tag).
      with(:span, class:%w(origin male).join(" ")).and_yield
    expect(bind).to receive(:content_tag).
      with(:span, class:%w(target female).join(" ")).and_yield
    expect(bind).to receive(:render).with(:references){ "references" }
    expect(bind).to receive(:render).
      with("references/form", reference: :reference){ "reference_form" }
    expect(presenter).to receive(:title).with(no_args){ "Owner" }
    expect(presenter).to receive(:origin).with(no_args){ "Origin" }
    expect(presenter).to receive(:target).with(no_args){ "Target" }
    expect(presenter).to receive(:origin_gender).with(no_args){ "male" }
    expect(presenter).to receive(:target_gender).with(no_args){ "female" }
    expect(presenter).to receive(:invert_link).with(no_args){ "invert_link" }
  end

  subject(:page){ Capybara.string(rendering).find('div.relation') }

  describe "Relation header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "Owner" }
  end

  describe "Relation origin" do
    its(:text){ should include "Origin" }
  end

  describe "Relation target" do
    its(:text){ should include "Target" }
  end

  describe "Invert link" do
    subject{ page.find '.actions .invert' }
    its(:text){ should eq "invert_link" }
  end

  describe "Reference form" do
    subject(:div){ page.find '.reference.new.form' }
    describe "Header" do
      subject{ div.find 'h2' }
      its(:text){ should eq "Add Reference" }
    end
    its(:text){ should include "reference_form" }
  end

end

