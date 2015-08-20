require 'rails_helper'
require 'vcr_helper'

describe "Create reference" do

  describe "creation successful" do
    it "" do
      VCR.use_cassette("create_reference_successfully") do
        begin
          universe = create :universe
          article = create :article, universe_id:universe.id
          note = create :note, article_id:article.id
          visit note_path note.id
          attach_file('Image', Rails.root + 'spec/pear.jpeg')
          fill_in 'Comment', with:'smart'
          fill_in 'Url', with:'www.example.com'
          click_on 'Create'
          expect(current_path).to eq note_path(note.id)
          expect(page).to have_content 'smart' 
          expect(page).to have_content 'www.example.com' 
        ensure
          delete :references
          delete :notes
          delete :articles
          delete :universes
        end
      end
    end
  end

end
