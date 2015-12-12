require 'rails_helper'
require 'vcr_helper'

describe "Show tag" do

  it "displays tagged notes after title" do
    VCR.use_cassette("display_tag_with_notes") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = tcreate :note, article_id:article.id, text:"90 W"
        tag = create :tag, title:'TDP'
        create :tagging, tag_id:tag.id, tagable_id:note.id, tagable_type:'Note'
        visit tag_path tag.id
        expect(page).to have_content 'TDP'
        expect(page).to have_content '90 W'
      ensure
        delete :taggings
        delete :tags
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
