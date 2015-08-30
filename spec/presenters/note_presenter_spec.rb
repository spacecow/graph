require './app/presenters/note_presenter'

describe NotePresenter do

  let(:note){ double :note }
  let(:template){ double :template }
  let(:presenter){ NotePresenter.new note, template }

  let(:tag){ double :tag, title:'TDP' }
  let(:tag2){ double :tag, title:'bandwidth' }

  describe "#tags" do
    subject{ presenter.tags }
    before{ expect(note).to receive(:tags){ tags }}

    context "one tag" do
      let(:tags){ [tag] }
      it{ is_expected.to eq 'TDP' }
    end

    context "two tags" do
      let(:tags){ [tag, tag2] }
      it{ is_expected.to eq 'TDP, bandwidth' }
    end

    context "no tags" do
      let(:tags){ [] }
      it{ is_expected.to eq '' }
    end
  end

end
