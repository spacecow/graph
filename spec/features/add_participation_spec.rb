require 'rails_helper'
require 'vcr_helper'

describe "Add participation" do

  context "addition successful" do
    it "" do
      VCR.use_cassette("add_participation_successfully") do
        begin
          universe = create :universe, title:"The Path of Daggers"
          visit universes_path
          click_link "The Path of Daggers"
          event = create :event, universe_id:universe.id
          create :article, universe_id:universe.id, name:"Ethenielle"
          visit event_path event.id
          expect(all(".participant option").map(&:text).first).to be_blank
          select "Ethenielle", from:"Participant"
          within(".participation form"){ click_button "Add" }
          expect(current_path).to eq event_path(event.id) 
          expect(page.find "ul.participants").to have_content "Ethenielle"
          expect(all(".participant option").map(&:text)).
            not_to include "Ethenielle" 
        ensure
          delete :participations
          delete :articles
          tdelete :events
          tdelete :universes
        end
      end
    end
  end

end
