require 'rails_helper'
require 'vcr_helper'

describe "Show tag" do

  it "displays tagged notes after title" do
    VCR.use_cassette("display_tag_with_notes") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:"90 W"
        tag = tcreate :tag, title:'TDP', tagable_id:note.id, tagable_type:'Note'
        visit tag_path tag.id
        expect(page).to have_content 'TDP'
        expect(page).to have_content '90 W'
      ensure
        tdelete :tags
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
