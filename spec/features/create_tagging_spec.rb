require 'rails_helper'
require 'vcr_helper'

describe "Create tagging" do

  it "creation successful" do
      VCR.use_cassette("create_tagging_successfully") do
        begin
          universe = create :universe
          article = create :article, universe_id:universe.id
          noting = tcreate :article_note, article_id:article.id
          tcreate :tag, title:'TDP'
          visit note_path noting.note_id
          select 'TDP', from:'Tags'
          click_on 'Create Tagging'
          expect(current_path).to eq note_path(noting.note_id)
          expect(page).to have_content 'TDP' 
        ensure
          tdelete :article_notes
          tdelete :tags
          delete :notes
          delete :articles
          tdelete :universes
        end
      end
  end

end
