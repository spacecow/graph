require 'view_helper'

describe 'notes/edit.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file.sub(/<%= form_for/,"<% form_for") }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding2.new locals }

  let(:filepath){ './app/views/notes/edit.html.erb' }
  let(:locals){{ note:note }}
  let(:note){ double :note, id: :id }
  let(:builder){ double :builder }

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
    end
    def bind.note_path id; raise NotImplementedError end
    def bind.form_for obj, *opts; raise NotImplementedError end
    expect(bind).to receive(:note_path).with(:id){ :path }
    expect(bind).to receive(:form_for).with(note, url: :path, method: :put).
      and_yield(builder)
    expect(builder).to receive(:label).with(:text,"Note"){ "label_text" }
    expect(builder).to receive(:text_area).with(:text){ "text_text" }
    expect(builder).to receive(:submit).with("Update"){ "submit_update" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form text" do
    subject{ page.find 'div.text' }
    its(:text){ should match /label_text\s*text_text/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_update" }
  end


end
