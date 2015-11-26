require 'rails_helper'
require 'vcr_helper'

describe "Create event" do

  context "Universe is not chosen" do
    it "Does a redirect" do
      VCR.use_cassette("try_to_create_event_but_not_allowed_access") do
        visit new_event_path
        expect(current_path).to eq universes_path 
      end
    end
  end

  describe "Successfully with parent and child" do
    it "" do
      VCR.use_cassette("create_event_successfully") do
        begin
          universe = create :universe, title:"Game of Thrones"
          visit universes_path
          click_link "Game of Thrones"
          parent = create :event, title:"Green wedding", universe_id:universe.id
          child = create :event, title:"Yellow wedding", universe_id:universe.id
          visit new_event_path
          fill_in "Title", with:"Red wedding"
          fill_in "Parents", with:parent.id
          fill_in "Children", with:child.id
          click_on "Create"
          expect(current_path).to match /events\/\d*/ 
          expect(page).to have_content "Green wedding" 
          expect(page).to have_content "Red wedding" 
          expect(page).to have_content "Yellow wedding" 
        ensure
          delete :steps
          delete :events
          delete :universes
        end
      end
    end
  end

end
