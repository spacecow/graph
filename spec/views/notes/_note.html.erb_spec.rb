require 'view_helper'

describe 'notes/_note.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:note){ double :note }
  let(:filepath){ './app/views/notes/_note.html.erb' }
  let(:locals){{ note:note }}

  before do
    def bind.note_path id; end
    expect(note).to receive(:text){ 'a note' }
    expect(note).to receive(:id){ 666 }
    expect(bind).to receive(:note_path).with(666){ "path" }
  end

  subject(:li){ Capybara.string(rendering).find 'li.note' }

  describe 'text' do
    subject(:text){ li.find '.text' }
    its(:text){ is_expected.to include 'a note' } 

    describe "link" do
      subject{ text.find 'a' }
      its(:text){ is_expected.to eq 'a note' }
      its([:href]){ is_expected.to eq "path" }
    end
  end

end
