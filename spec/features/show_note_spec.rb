require 'rails_helper'
require 'vcr_helper'

describe 'Show note' do

  it "displays the note with its references and tags" do
    VCR.use_cassette("display_note_with_references") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:'a note'
        tcreate :article_note, article_id:article.id, note_id:note.id
        create :reference, referenceable_id:note.id, url:'www.example.com',
          referenceable_type:"Note"
        tcreate :tag, title:'TDP', tagable_id:note.id, tagable_type:'Note'
        visit note_path note.id
        expect(current_path).to eq note_path(note.id)
        expect(page).to have_selector 'li.tag'
        expect(page).to have_content 'a note'
        expect(page).to have_content 'www.example.com'
      ensure
        tdelete :article_notes
        delete :references
        tdelete :tags
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

  pending "navigate to a tag page"

  it "navigate to a reference page" do
    VCR.use_cassette('navigate_to_a_reference_page') do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:'a note'
        tcreate :article_note, article_id:article.id, note_id:note.id
        reference = create :reference, referenceable_id:note.id,
          url:'www.example.com', referenceable_type:"Note"
        visit note_path note.id
        click_link 'www.example.com'
        expect(current_path).to eq reference_path(reference.id)
      ensure
        tdelete :article_notes
        delete :references
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
