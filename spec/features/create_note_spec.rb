require 'rails_helper'
require 'vcr_helper'

describe "Create note" do

  describe "creation successful" do

    let(:universe){ create :universe, title:'The Malazan Empire' }
    let(:universe_id){ universe.id }
    let(:article){ create :article, universe_id:universe_id }
    let(:article_id){ article.id }
    
    it "" do
      VCR.use_cassette("create_note_successfully") do
        begin
          universe
          visit universes_path
          click_link 'The Malazan Empire'
          visit article_path article_id
          fill_in 'Note', with:'a note'
          click_on 'Create'
          expect(current_path).to eq article_path(article_id)
          expect(page).to have_content 'a note' 
        ensure
          delete :notes
          delete :articles
          delete :universes
        end
      end
    end

  end

end
