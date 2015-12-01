require 'rails_helper'
require 'vcr_helper'

describe "Edit note" do

  it "Successfully" do
    VCR.use_cassette('edit_note_successfully') do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        article = create :article, universe_id:universe.id
        note = create :note, article_id:article.id, text:"an old note"
        visit edit_note_path note.id
        fill_in 'Note', with:"an updated note"
        click_on 'Update'
        expect(current_path).to eq article_path(note.article_id)
        expect(page).to have_content 'an updated note' 
      ensure
        delete :notes
        delete :articles
        delete :universes
      end
    end
  end

end
