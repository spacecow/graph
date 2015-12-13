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

end
