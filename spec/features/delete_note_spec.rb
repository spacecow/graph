require 'vcr_helper'
require 'rails_helper'

describe "Delete note" do

  it "Successfully from tag" do
    VCR.use_cassette("delete_note_from_tag_successfully") do
      begin
        universe = create :universe
        tag = create :tag, title:'TDP'
        article = create :article, universe_id:universe.id
        note = create :note, article_id:article.id, text:"90 W"
        create :tagging, tag_id:tag.id, tagable_id:note.id, tagable_type:'Note'
        visit tag_path tag.id
        expect(page).to have_content '90 W'
        within('li.note'){ click_link "Delete" }
        expect(current_path).to eq tag_path(tag.id) 
        expect(page).not_to have_content '90 W'
      ensure
        delete :taggings
        delete :tags
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

  it "Successfully from article" do
    VCR.use_cassette("delete_note_from_article_successfully") do
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
