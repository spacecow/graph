require 'rspec/its'
require 'capybara'

describe "citations/_form.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/citations/_form.html.erb" }
  let(:locals){{ citation: :citation, targets: :targets }}
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
    expect(bind).to receive(:form_for).with(:citation).and_yield(builder)
    expect(builder).to receive(:hidden_field).with(:origin_id){ "hidden_origin_id" }
    expect(builder).to receive(:label).with(:content, "Citation"){ "label_content" }
    expect(builder).to receive(:text_field).with(:content){ "text_content" }
    expect(builder).to receive(:label).with(:target_id, "About"){ "label_target" }
    expect(builder).to receive(:collection_select).
      with(:target_id, :targets, :id, :name, include_blank:true){ "select_target" }
    expect(builder).to receive(:submit).with("Add"){ "add_citation" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form origin_id" do
    its(:text){ should include "hidden_origin_id" } 
  end

  describe "Form content" do
    subject{ page.find 'div.content' }
    its(:text){ should match /label_content\s*text_content/m }
  end

  describe "Form target" do
    subject{ page.find 'div.target' }
    its(:text){ should match /label_target\s*select_target/m }
  end


  describe "Form submit" do
    its(:text){ should include "add_citation" }
  end

end
