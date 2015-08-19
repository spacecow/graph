require 'rails_helper'
require 'vcr_helper'

describe "Create note" do

  describe "creation successful" do
    it "" do
      VCR.use_cassette("create_note_successfully") do
        begin
          universe = create :universe, title:'The Malazan Empire'
          article = create :article, universe_id:universe.id
          visit universes_path
          click_link 'The Malazan Empire'
          visit article_path article.id
          fill_in 'Note', with:'a note'
          click_on 'Create'
          expect(current_path).to eq article_path(article.id)
          expect(page).to have_content 'a note' 
        ensure
          delete :notes
          delete :articles
          delete :universes
        end
      end
    end
  end

  describe "creation failure" do
    it "text cannot be blank" do
      VCR.use_cassette("create_note_with_blank_text_violation") do
        begin
          universe = create :universe, title:'The Malazan Empire'
          article = create :article, universe_id:universe.id
          visit universes_path
          click_link 'The Malazan Empire'
          visit article_path article.id
          fill_in 'Note', with:''
          click_on 'Create'
          expect(current_path).to eq notes_path 
          expect(page.find('.text .errors').text).to eq 'cannot be blank'
        ensure
          delete :notes
          delete :articles
          delete :universes
        end
      end
    end
  end

end