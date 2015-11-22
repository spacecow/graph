require 'rails_helper'
require 'vcr_helper'

describe "Show event" do

  it "display event" do
    VCR.use_cassette("display_event") do
      begin
        universe = create :universe
        event = create :event, universe_id:universe.id, title:"Red wedding"
        visit event_path event.id
        expect(page).to have_content "Red wedding"
      ensure
        delete :events
        delete :universes
      end
    end
  end

end
