require 'rails_helper'
require 'vcr_helper'

describe "Show event" do

  it "display event with parent and participants" do
    VCR.use_cassette("display_event") do
      begin
        universe = create :universe, title:"Game of Thrones"
        visit universes_path
        click_link "Game of Thrones"
        parent = create :event, universe_id:universe.id, title:"Green wedding"
        event = tcreate :event, universe_id:universe.id, title:"Red wedding"
        note = tcreate :note, text:'a note'
        tcreate :event_note, event_id:event.id, note_id:note.id
        create :step, parent_id:parent.id, child_id:event.id
        article = create :article, universe_id:universe.id, name:"John Snow",
          gender:'m'
        create :participation, article_id:article.id, event_id:event.id
        #TODO event and article should be in the same universe!
        visit event_path event.id
        expect(page).to have_content "Green wedding"
        expect(page).to have_content "Red wedding"
        expect(page).to have_content "a note"
        expect(page.find '.participants .male').to have_content "John Snow"
      ensure
        tdelete :event_notes
        delete :notes
        delete :steps
        delete :participations
        delete :articles
        tdelete :events
        tdelete :universes
      end
    end
  end

end
