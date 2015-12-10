require 'active_support/core_ext/string/output_safety'
require './app/presenters/base_presenter'
require './app/presenters/note_presenter'

describe NotePresenter do

  let(:note){ double :note }
  let(:view){ double :view }
  let(:presenter){ NotePresenter.new note, view }
  let(:params){ [] }

  subject{ presenter.send function, *params }

  describe "#edit_link" do
    let(:function){ :edit_link }
    before do
      expect(view).to receive(:edit_note_path).with(:id){ :path }
      expect(view).to receive(:link_to).with("Edit",:path){ :link }
      expect(note).to receive(:id).with(no_args){ :id }
    end
    it{ should be :link }
  end

  describe "#delete_link" do
    let(:function){ :delete_link }
    let(:params){[{ article_id: :article_id, tag_id: :tag_id }]}
    before do
      expect(view).to receive(:link_to).
        with("Delete",:path,method: :delete, data:{confirm:"Are you sure?"}).
        and_return(:link)
      expect(view).to receive(:note_path).
        with(:id, article_id: :article_id, tag_id: :tag_id){ :path }
      expect(note).to receive(:id).with(no_args){ :id }
    end
    it{ should be :link }
  end

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
