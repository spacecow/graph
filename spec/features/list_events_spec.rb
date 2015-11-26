require 'rails_helper'
require 'vcr_helper'

describe "List events" do

  it "Displays available events" do
    VCR.use_cassette('displays_available_events') do
      begin
        #TODO chose universe
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        create :event, title:'The horse ride', universe_id:universe.id
        create :event, title:'Red wedding'
        visit events_path
        expect(page).to have_content 'The horse ride'
        expect(page).not_to have_content 'Red wedding'
      ensure
        delete :events
        delete :universes
      end
    end
  end

  it "navigate to an event" do
    VCR.use_cassette("navigate_to_an_event") do
      begin
        universe = create :universe, title:"The Malazan Empire"
        visit universes_path
        click_link "The Malazan Empire"
        event = create :event, universe_id:universe.id, title:"The Mage War"
        visit events_path
        click_link "The Mage War"
        expect(current_path).to eq event_path(event.id) 
      ensure
        delete :events
        delete :universes
      end
    end
  end

end
