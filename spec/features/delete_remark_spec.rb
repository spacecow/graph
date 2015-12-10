require 'rails_helper'
require 'vcr_helper'

describe "Delete remark" do

  it "Successfully" do
    VCR.use_cassette("delete_remark_successfully") do
      begin
        remarkable = tcreate :remarkable
        event = tcreate :event, remarkable_id:remarkable.id
        remark = tcreate :remark, remarkable_id:remarkable.id, content:"a remark"
        visit universes_path
        click_link event.universe_title 
        visit event_path event.id
        expect(current_path).to eq event_path(event.id)
        expect(page).to have_content "a remark"
        within('li.remark'){ click_link "Delete" }
        expect(current_path).to eq event_path(event.id)
        expect(page).not_to have_content "a remark"
      ensure
        tdelete :events
        tdelete :universes
      end
    end
  end

end
