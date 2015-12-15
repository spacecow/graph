require 'rspec/its'
require 'capybara'

describe "taggings/_form.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/taggings/_form.html.erb" }
  let(:locals){{ tagging: :tagging, tags: :tags }}
  let(:builder){ double :builder }

  subject(:page){ Capybara.string rendering }

  before do 
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
        def form_for obj; raise NotImplementedError end
      end
    end
    expect(bind).to receive(:form_for).with(:tagging).and_yield(builder)
    expect(builder).to receive(:hidden_field).
      with(:tagable_id){ "hidden_tagable_id" }
    expect(builder).to receive(:hidden_field).
      with(:tagable_type){ "hidden_tagable_type" }
    expect(builder).to receive(:label).with(:tag_id,"Tag"){ "label_tag_id" }
    expect(builder).to receive(:collection_select).
      with(:tag_id,:tags,:id,:title){ "select_tag_id" }
    expect(builder).to receive(:submit).with("Create Tagging"){ "submit_create" }
  end

  describe "Form taggable_id" do
    its(:text){ should include "hidden_tagable_id" }
  end

  describe "Form taggable_type" do
    its(:text){ should include "hidden_tagable_type" }
  end

  describe "Form tag" do
    subject{ page.find 'div.tag' }
    its(:text){ should match /label_tag_id\s*select_tag_id/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_create" }
  end



end
