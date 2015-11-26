require 'capybara'
require 'rspec/its'

describe 'steps/_form.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form_for/,"<% form_for") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/steps/_form.html.erb' }
  let(:locals){{ step: :step, parents: :parents }}
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
    expect(bind).to receive(:form_for).with(:step).and_yield(builder)
    expect(builder).to receive(:hidden_field).with(:child_id){ "hidden_child" }
    expect(builder).to receive(:label).with(:parent_id,"Parent"){ "label_parent" }
    expect(builder).to receive(:collection_select).
      with(:parent_id, :parents, :id, :title, include_blank:true){ "select_parent" }
    expect(builder).to receive(:submit).with("Add"){ "submit_add" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form child" do
    its(:text){ should include "hidden_child" }
  end

  describe "Form participant" do
    subject{ page.find 'div.parent' }
    its(:text){ should match /label_parent\s*select_parent/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_add" }
  end

end
