require 'rails_helper'
require 'vcr_helper'

describe "Create tagging" do

  it "creation successful" do
      VCR.use_cassette("create_tagging_successfully") do
        begin
          universe = create :universe
          article = create :article, universe_id:universe.id
          note = create :note, article_id:article.id
          create :tag, title:'TDP'
          visit note_path note.id
          select 'TDP', from:'Tags'
          click_on 'Create Tagging'
          expect(current_path).to eq note_path(note.id)
          expect(page).to have_content 'TDP' 
        ensure
          delete :taggings
          delete :tags
          delete :notes
          delete :articles
          delete :universes
        end
      end
  end

end