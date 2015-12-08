require 'rails_helper'
require 'vcr_helper'

describe "Delete event" do

  it "successfully" do
    VCR.use_cassette("successfully_delete_event") do
      begin
        universe = create :universe, title:"Game of Thrones"
        visit universes_path
        click_link "Game of Thrones"
        create :event, title:"Red wedding", universe_id:universe.id
        visit events_path
        expect(current_path).to eq events_path
        expect(page).to have_content "Red wedding"
        within('li.event'){ click_link 'Delete' }
        expect(current_path).to eq events_path
        expect(page).not_to have_content "Red wedding"
      ensure
        tdelete :events
        tdelete :universes
      end
    end
  end

end
