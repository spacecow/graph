require 'rspec/its'
require 'capybara'

describe "references/_form.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/references/_form.html.erb" }
  let(:locals){{ reference: :reference }}
  let(:builder){ double :builder }

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    def bind.form_for obj; raise NotImplementedError end
    expect(bind).to receive(:form_for).with(:reference).and_yield(builder)
    expect(builder).to receive(:hidden_field).
      with(:referenceable_id){ "hidden_referenceable_id" }
    expect(builder).to receive(:hidden_field).
      with(:referenceable_type){ "hidden_referenceable_type" }
    expect(builder).to receive(:label).with(:comment){ "label_comment" }
    expect(builder).to receive(:text_field).with(:comment){ "text_comment" }
    expect(builder).to receive(:submit).with("Add"){ "submit_add" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form referenceable_id" do
    its(:text){ should include "hidden_referenceable_id" }
  end

  describe "Form referenceable_type" do
    its(:text){ should include "hidden_referenceable_type" }
  end

  describe "Form comment" do
    subject{ page.find 'div.comment' }
    its(:text){ should match /label_comment\s*text_comment/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_add" }
  end

end
