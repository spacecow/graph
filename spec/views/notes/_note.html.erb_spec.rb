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
  let(:presenter){ double :presenter }

  before do
    def bind.note_path id; end
    def bind.present mdl; end
    expect(bind).to receive(:present).with(note).and_yield presenter
    expect(note).to receive(:text).with(no_args){ 'a note' }
    expect(note).to receive(:id).with(no_args){ 666 }
    expect(bind).to receive(:note_path).with(666){ "path" }
    expect(presenter).to receive(:tags).with(no_args){ "TDP" }
    expect(presenter).to receive(:edit_link).with(no_args){ "edit_note_link" }
    expect(presenter).to receive(:delete_link).with(no_args){ "delete_note_link" }
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

  describe 'actions' do
    subject(:actions){ li.find '.actions' }
    describe 'edit' do
      subject{ actions.find '.edit' }
      its(:text){ is_expected.to eq "edit_note_link" }
    end
    describe 'edit' do
      subject{ actions.find '.delete' }
      its(:text){ is_expected.to eq "delete_note_link" }
    end
  end

  describe 'tags' do
    subject{ li.find '.tags' }
    its(:text){ is_expected.to include 'TDP' }
  end

end
