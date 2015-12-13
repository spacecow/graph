require 'rails_helper'
require 'vcr_helper'

describe "Create event note" do

  it "Successfully" do
    VCR.use_cassette("create_event_note_successfully") do
      begin
        event = tcreate :event
        visit universes_path
        click_link event.universe_title
        visit event_path(event.id)
        fill_in 'Note', with:'a note'
        click_on 'Create'
        expect(current_path).to eq event_path(event.id)
        expect(page).to have_content 'a note' 
      ensure
        tdelete :event_notes
        delete :notes
        tdelete :events
        tdelete :universes
      end
    end
  end

  #  it "" do
  #    VCR.use_cassette("create_article_note_successfully") do
  #      begin
  #        universe = create :universe, title:'The Malazan Empire'
  #        visit universes_path
  #        click_link 'The Malazan Empire'
  #        article = create :article, universe_id:universe.id
  #        visit article_path article.id
  #        fill_in 'Note', with:'a note'
  #        click_on 'Create'
  #        expect(current_path).to eq article_path(article.id)
  #        expect(page).to have_content 'a note' 
  #      ensure
  #        tdelete :article_notes
  #        delete :notes
  #        delete :articles
  #        tdelete :universes
  #      end
  #    end
  #  end
  #end

end
