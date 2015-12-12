require 'rails_helper'
require 'vcr_helper'

describe "Update note" do

  it "Successfully" do
    VCR.use_cassette('edit_note_successfully') do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:"an old note"
        tcreate :article_note, article_id:article.id, note_id:note.id
        visit edit_note_path note.id
        fill_in 'Note', with:"an updated note"
        click_on 'Update'
        expect(current_path).to eq article_path(article.id)
        expect(page).to have_content 'an updated note' 
      ensure
        tdelete :article_notes
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
