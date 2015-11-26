require 'rails_helper'
require 'vcr_helper'

describe "Add parent" do

  context "addition successful" do
    it "" do
      VCR.use_cassette("add_parent_successfully") do
        begin
          universe = create :universe, title:"The Path of Daggers"
          visit universes_path
          click_link "The Path of Daggers"
          parent = create :event, universe_id:universe.id, title:"The Beginning"
          event = create :event, universe_id:universe.id, title:"The Middle"
          visit event_path event.id
          expect(all(".parent option").map(&:text)).not_to include "The Middle"
          expect(all(".parent option").map(&:text).first).to be_blank
          select "The Beginning", from:"Parent"
          within(".parent form"){ click_button "Add" }
          expect(current_path).to eq event_path(event.id) 
          expect(page.find "ul.parents").to have_content 'The Beginning'
          expect(all(".parent option").map(&:text)).not_to include "The Beginning"
        ensure
          delete :steps
          delete :events
          delete :universes
        end
      end
    end
  end

end
