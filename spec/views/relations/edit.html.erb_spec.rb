require 'capybara'
require 'rspec/its'

describe 'relations/edit.html.erb' do

  let(:erb){ ERB.new file.gsub(/<%= form_for/,'<% form_for') }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding2.new locals }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/relations/edit.html.erb' }
  let(:locals){{ relation:mdl, relation_types: :types }}
  let(:mdl){ double :mdl }

  let(:builder){ double :builder }

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end
      end
    end
    def bind.relation_path id; raise NotImplementedError end
    def bind.form_for obj, opts; raise NotImplementedError end
    expect(bind).to receive(:relation_path).with(:id){ :path }
    expect(bind).to receive(:form_for).with(mdl, url: :path, method: :put).and_yield(builder)
    expect(mdl).to receive(:id).with(no_args){ :id }
    expect(builder).to receive(:label).with(:type, "Relation"){ "label_type" }
    expect(builder).to receive(:select).with(:type, :types, include_blank:true){ "select_type" }
    expect(builder).to receive(:submit).with("Update"){ "submit_update" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form type" do
    subject{ page.find 'div.type' }
    its(:text){ should match /label_type\s*select_type/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_update" }
  end

end
