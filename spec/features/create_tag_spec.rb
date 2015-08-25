require 'rails_helper'
require 'vcr_helper'

describe "Create note" do

  describe "creation successful" do
    it "" do
      VCR.use_cassette("create_tag_successfully") do
        begin
          universe = create :universe
          article = create :article, universe_id:universe.id
          note = create :note, article_id:article.id
          visit note_path note.id
          fill_in 'Title', with:'TDP'
          click_on 'Create Tag'
          expect(current_path).to eq note_path(note.id)
          #TODO check tag is listed 
        ensure
          delete :tags
          delete :notes
          delete :articles
          delete :universes
        end
      end
    end
  end
  
end
