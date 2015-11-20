require 'active_support/core_ext/string/output_safety'
require './app/presenters/note_presenter'

describe NotePresenter do

  let(:note){ double :note }
  let(:view){ double :view }
  let(:presenter){ NotePresenter.new note, view }

  subject{ presenter.send function }

  describe "#tags" do
    let(:function){ :tags }
    let(:tag){ double :tag }
    let(:tag2){ double :tag }
    
    before{ expect(note).to receive(:tags){ tags }}

    context "tag exists" do
      let(:tags){ [tag] }
      before do
        expect(view).to receive(:link_to).with(:title, :path){ "TDP" }
        expect(view).to receive(:tag_path).with(:id){ :path }
        expect(tag).to receive(:title).with(no_args){ :title }
        expect(tag).to receive(:id).with(no_args){ :id }
      end
      it{ is_expected.to eq 'TDP' }
    end

    context "no tags" do
      let(:tags){ [] }
      it{ is_expected.to eq '' }
    end
  end

end
