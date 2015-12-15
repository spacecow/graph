require 'rails_helper'
require 'vcr_helper'

describe "Update event" do

  it "Successfully" do
    VCR.use_cassette("update_event_successfully") do
      begin
        event = tcreate :event, title:"an old title"
        visit universes_path
        click_link event.universe_title
        visit edit_event_path(event.id)
        fill_in 'Title', with:"an updated title"
        click_on "Update"
        expect(current_path).to eq event_path(event.id) 
        expect(page).to have_content "an updated title" 
      ensure
        tdelete :events
        tdelete :universes
      end
    end
  end

end
