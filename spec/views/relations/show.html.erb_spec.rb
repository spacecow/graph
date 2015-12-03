require 'view_helper'

describe 'notes/edit.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding2.new locals }

  let(:filepath){ './app/views/relations/show.html.erb' }
  let(:locals){{ relation:relation, references: :references,
    reference: :reference }}
  let(:relation){ double :relation }

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end
      end
    end
    def bind.render obj, *opts; raise NotImplementedError end
    expect(relation).to receive(:type).with(no_args){ "Owner" }
    expect(bind).to receive(:render).with(:references){ "references" }
    expect(bind).to receive(:render).
      with("references/form", reference: :reference){ "reference_form" }
  end

  subject(:page){ Capybara.string(rendering).find('div.relation') }

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "Owner" }
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

