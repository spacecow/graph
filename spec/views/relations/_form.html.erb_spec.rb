require 'capybara'
require 'rspec/its'

describe 'relations/_form.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form_for/,"<% form_for") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/relations/_form.html.erb' }
  let(:targets){ double :targets } 
  let(:locals){{ relation: :relation, article_id: :article_id,
                 relation_types: :relation_types, target_ids:[666, 888] }}
  let(:builder){ double :builder }

  before do
    class ErbBinding
      def initialize hash
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    def bind.form_for obj; raise NotImplementedError end
    def bind.articles_path opt; raise NotImplementedError end
    expect(bind).to receive(:form_for).with(:relation).and_yield(builder)
    expect(bind).to receive(:articles_path).
      with(format: :json, article_id: :article_id, target_ids:"666_888"){ :articles_path }
    expect(builder).to receive(:hidden_field).with(:origin_id){ "hidden_origin" }
    expect(builder).to receive(:label).
      with(:type,"Relation"){ "label_type" }
    expect(builder).to receive(:select).
      with(:type,:relation_types,include_blank:true){ "select_type" }
    expect(builder).to receive(:label).
      with(:target_id,"Relative"){ "label_target" }
    expect(builder).to receive(:text_field).
      with(:target_id, data:{url: :articles_path}){ "select_target" }
    expect(builder).to receive(:submit).with("Add"){ "submit_add" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form origin" do
    its(:text){ should include "hidden_origin" }
  end

  describe "Form type" do
    subject{ page.find 'div.type' }
    its(:text){ should match /label_type\s*select_type/m }
  end

  describe "Form target" do
    subject{ page.find 'div.target' }
    its(:text){ should match /label_target\s*select_target/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_add" }
  end

end
