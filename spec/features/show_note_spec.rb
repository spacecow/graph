require 'rails_helper'
require 'vcr_helper'

describe 'Show note' do

  it "displays the note with its references" do
    VCR.use_cassette("display_note_with_references") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = create :note, article_id:article.id, text:'a note'
        create :reference, note_id:note.id, url:'www.example.com'
        visit note_path note.id
        expect(current_path).to eq note_path(note.id)
        expect(page).to have_content 'a note'
        expect(page).to have_content 'www.example.com'
      ensure
        delete :references
        delete :notes
        delete :articles
        delete :universes
      end
    end
  end

  it "navigate to a reference page" do
    VCR.use_cassette('navigate_to_a_reference_page') do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = create :note, article_id:article.id, text:'a note'
        reference = create :reference, note_id:note.id, url:'www.example.com'
        visit note_path note.id
        click_link 'www.example.com'
        expect(current_path).to eq reference_path(reference.id)
      ensure
        delete :references
        delete :notes
        delete :articles
        delete :universes
      end
    end
  end

end
