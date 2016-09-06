require 'rails_helper'
require 'vcr_helper'

describe 'Show note' do

  it "displays the note with its references and tags" do
    VCR.use_cassette("display_note_with_references") do
      begin
        universe = create :universe, title:"Game of Thrones"
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:'a note'
        tcreate :article_note, article_id:article.id, note_id:note.id
        create :reference, referenceable_id:note.id, url:'www.example.com',
          referenceable_type:"Note"
        tcreate :tag,
          title:'TDP', universe_id:universe.id,
          tagable_id:note.id, tagable_type:'Note'
        visit universes_path
        click_link "Game of Thrones"
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

  it "Delete note tag" do
    VCR.use_cassette('delete_note_tag') do
      begin
        universe = create :universe, title:"Game of Thrones"
        note = tcreate :note
        tcreate :tag, universe_id:universe.id, title:'Hodor',
          tagable_id:note.id, tagable_type:'Note'
        visit universes_path
        click_link "Game of Thrones"
        visit note_path note.id
        expect(page).to have_content 'Hodor'
        click_link 'Delete'
        expect(current_path).to eq note_path(note.id)
        expect(page).not_to have_content 'Hodor'
      ensure
        tdelete :tags
        delete :notes
        tdelete :universes
      end
    end
  end

  pending "navigate to a tag page"

  it "navigate to a reference page" do
    VCR.use_cassette('navigate_to_a_reference_page') do
      begin
        universe = create :universe, title:"Game of Thrones"
        article = create :article, universe_id:universe.id
        note = tcreate :note, text:'a note'
        tcreate :article_note, article_id:article.id, note_id:note.id
        reference = create :reference, referenceable_id:note.id,
          url:'www.example.com', referenceable_type:"Note"
        visit universes_path
        click_link "Game of Thrones"
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
