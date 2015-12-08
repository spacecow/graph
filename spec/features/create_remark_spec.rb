require 'rails_helper'
require 'vcr_helper'

describe "Create remark" do

  it "Successfully" do
    VCR.use_cassette("create_remark_successfully") do
      begin
        event = tcreate :event
        visit universes_path
        click_link event.universe_title 
        visit event_path event.id
        fill_in "Remark", with:"a remark"
        within('.remark.form'){ click_button "Add" }
        expect(current_path).to eq event_path(event.id)
        expect(page).to have_content "a remark"
      ensure
        tdelete :events
        tdelete :universes
      end
    end
  end

end
