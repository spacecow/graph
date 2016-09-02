require 'vcr_helper'
require 'rails_helper'

describe "Delete article note" do

  it "Failingly from tag" do
    VCR.use_cassette("delete_article_note_from_tag_successfully") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:"90 W"
        tcreate :article_note, article_id:article.id, note_id:note.id
        tag = tcreate :tag,
          tagable_id:note.id, tagable_type:'Note', title:"TDP", universe_id:universe.id
        visit tag_path tag.id
        expect(page).to have_content '90 W'
        within('li.note'){ click_link "Delete" }
        expect(current_path).to eq tag_path(tag.id) 
        expect(page).to have_content '90 W'
      ensure
        tdelete :article_notes
        tdelete :tags
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

  it "Successfully from article" do
    VCR.use_cassette("delete_article_note_from_article_successfully") do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:"Square-faced"
        tcreate :article_note, article_id:article.id, note_id:note.id
        visit article_path article.id
        expect(page).to have_content "Square-faced"
        within('li.note'){ click_link "Delete" }
        expect(current_path).to eq article_path(article.id) 
        expect(page).not_to have_content "Square-faced"
      ensure
        tdelete :article_notes
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
