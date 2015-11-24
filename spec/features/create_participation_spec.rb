require 'rails_helper'
require 'vcr_helper'

describe "Create participation" do

  context "creation successful" do
    it "" do
      VCR.use_cassette("create_participation_successfully") do
        begin
          universe = create :universe, title:"The Path of Daggers"
          event = create :event, universe_id:universe.id
          create :article, universe_id:universe.id, name:"Ethenielle"
          visit universes_path
          click_link "The Path of Daggers"
          visit event_path event.id
          select "Ethenielle", from:"Participant"
          click_button "Add"
          expect(current_path).to eq event_path(event.id) 
          expect(page).to have_content 'Ethenielle'
        ensure
          delete :participations
          delete :articles
          delete :events
          delete :universes
        end
      end
    end
  end

end
