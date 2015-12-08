require 'rspec/its'
require 'capybara'

describe "remarks/_form.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,'<% form') }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/remarks/_form.html.erb" }
  let(:locals){{ remark: :remark, event_id: :event_id }}
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
    def bind.hidden_field_tag *opts; raise NotImplementedError end
    expect(bind).to receive(:form_for).with(:remark).and_yield(builder)
    expect(bind).to receive(:hidden_field_tag).
      with(:event_id,:event_id){ "hidden_event_id" }
    expect(builder).to receive(:label).with(:content,"Remark"){ "label_content" }
    expect(builder).to receive(:text_field).with(:content){ "text_content" }
    expect(builder).to receive(:submit).with("Add"){ "submit_add" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form event_id" do
    its(:text){ should include "hidden_event_id" }
  end

  describe "Form content" do
    subject{ page.find 'div.content' }
    its(:text){ should match /label_content\s*text_content/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_add" }
  end

end
