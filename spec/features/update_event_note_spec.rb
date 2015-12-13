require 'rails_helper'
require 'vcr_helper'

describe "Update event note" do

  it "Successfully" do
    VCR.use_cassette('update_event_note_successfully') do
      begin
        event = tcreate :event
        visit universes_path
        click_link event.universe_title
        note = tcreate :note, text:"a note"
        tcreate :event_note, event_id:event.id, note_id:note.id
        visit event_path(event.id)
        within('li.note'){ click_link "Edit" }
        fill_in 'Note', with:"an updated note"
        click_on 'Update'
        expect(current_path).to eq event_path(event.id)
        expect(page).to have_content 'an updated note' 
      ensure
        tdelete :event_notes
        tdelete :notes
        tdelete :events
        tdelete :universes
      end
    end
  end

end
