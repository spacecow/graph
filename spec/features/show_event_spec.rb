require 'rails_helper'
require 'vcr_helper'

describe "Show event" do

  it "display event with parent and participants" do
    VCR.use_cassette("display_event") do
      begin
        universe = create :universe, title:"Game of Thrones"
        visit universes_path
        click_link "Game of Thrones"
        parent = tcreate :event, universe_id:universe.id, title:"Green wedding"
        event = tcreate :event, universe_id:universe.id, title:"Red wedding"
        note = tcreate :note, text:'a note'
        tcreate :event_note, event_id:event.id, note_id:note.id
        create :step, parent_id:parent.id, child_id:event.id
        article = create :article, universe_id:universe.id, name:"John Snow",
          gender:'m'
        create :participation, participant_id:article.id, event_id:event.id
        blue = tcreate :event, title:"Blue wedding"
        tcreate :mention, origin_id:event.id, target_id:blue.id
        #TODO event and article should be in the same universe!
        visit event_path event.id
        expect(page).to have_content "Green wedding"
        expect(page).to have_content "Red wedding"
        expect(page).to have_content "a note"
        expect(page.find 'li.mention').to have_content "Blue wedding"
        expect(page.find '.participations .male').to have_content "John Snow"
      ensure
        tdelete :mentions
        tdelete :event_notes
        delete :notes
        delete :steps
        tdelete :participations
        delete :articles
        tdelete :events
        tdelete :universes
      end
    end
  end

  it "navigate to a participant page" do
    VCR.use_cassette('navigate_to_a_participant_page') do
      begin
        event = tcreate :event
        article = create :article, name:"Ethenielle", universe_id:event.universe_id
        visit universes_path
        click_link event.universe_title
        tcreate :participation, event_id:event.id, participant_id:article.id
        visit event_path event.id
        click_link "Ethenielle"
        expect(current_path).to eq article_path(article.id)
      ensure
        tdelete :participations
        delete :articles
        tdelete :events
        tdelete :universes 
      end
    end
  end


end
