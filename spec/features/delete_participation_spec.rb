require 'rails_helper'
require 'vcr_helper'

describe "Delete participation" do

  it "Successfully" do
    VCR.use_cassette("delete_participation_successfully") do
      begin
        event = tcreate :event 
        visit universes_path
        click_link event.universe_title
        tcreate :participation, event_id:event.id
        visit event_path(event.id)
        expect(page).to have_selector 'li.participation'
        within('li.participation'){ click_link "Delete" }
        expect(current_path).to eq event_path(event.id)
        expect(page).not_to have_selector 'li.participation'
      ensure
        tdelete :participations
        delete :articles
        tdelete :events
        tdelete :universes
      end
    end
  end
 
end
