require 'vcr_helper'
require 'rails_helper'

describe "Delete note" do

  it "Successfully" do
    VCR.use_cassette("delete_note_successfully") do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        article = create :article, universe_id:universe.id
        create :note, article_id:article.id, text:"Square-faced"
        visit article_path article.id
        expect(page).to have_content "Square-faced"
        within('li.note'){ click_link "Delete" }
        expect(current_path).to eq article_path(article.id) 
        expect(page).not_to have_content "Square-faced"
      ensure
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
