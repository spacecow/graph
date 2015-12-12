require 'rspec/its'
require 'capybara'

describe "remarks/_form.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,'<% form') }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/remarks/_form.html.erb" }
  let(:locals){{ remark:remark, event_id: :event_id }}
  let(:builder){ double :builder }
  let(:remark){ double :remark, id:remark_id }

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    def bind.form_for obj, *opts; raise NotImplementedError end
    def bind.hidden_field_tag *opts; raise NotImplementedError end
    def bind.remark_path id; raise NotImplementedError end
    def bind.remarks_path; raise NotImplementedError end
    expect(bind).to receive(:form_for).with(remark,url: :path, method:method).
      and_yield(builder)
    expect(bind).to receive(:hidden_field_tag).
      with(:event_id,:event_id){ "hidden_event_id" }
    expect(builder).to receive(:label).with(:content,"Remark"){ "label_content" }
    expect(builder).to receive(:text_area).with(:content){ "text_content" }
  end

  subject(:page){ Capybara.string rendering }

  context "New remark" do
    let(:remark_id){ nil }
    let(:method){ :post }
    before do
      expect(bind).not_to receive(:remark_path)
      expect(bind).to receive(:remarks_path).with(no_args){ :path }
      expect(builder).to receive(:submit).with("Add"){ "submit_add" }
    end
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

  context "Edit remark" do
    let(:remark_id){ :id }
    let(:method){ :put }
    before do
      expect(bind).to receive(:remark_path).with(:id){ :path }
      expect(bind).not_to receive(:remarks_path)
      expect(builder).to receive(:submit).with("Update"){ "submit_update" }
    end
    describe "Form submit" do
      its(:text){ should include "submit_update" }
    end
  end

end
