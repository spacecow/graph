require 'rails_helper'
require 'vcr_helper'

describe "Delete event note" do

  it "Successfully from event" do
    VCR.use_cassette("delete_event_note_from_event_successfully") do
      begin
        event = tcreate :event
        visit universes_path
        click_link event.universe_title
        note = tcreate :note, text:"High altitude"
        tcreate :event_note, event_id:event.id, note_id:note.id
        visit event_path event.id  
        expect(page).to have_content "High altitude"
        within('li.note'){ click_link "Delete" }
        expect(current_path).to eq event_path(event.id) 
        expect(page).not_to have_content "High altitude"
      ensure
        tdelete :event_notes
        delete :ntoes
        tdelete :events
        tdelete :universes
      end  
    end
  end

end
