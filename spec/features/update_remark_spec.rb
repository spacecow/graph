require 'rails_helper'
require 'vcr_helper'

describe "Update remark" do

  it "Successfully" do
    VCR.use_cassette('update_remark_successfully') do
      begin
        remarkable = tcreate :remarkable
        event = tcreate :event, remarkable_id:remarkable.id
        visit universes_path
        click_link event.universe_title 
        remark = tcreate :remark, remarkable_id:remarkable.id
        visit edit_remark_path(remark.id, event_id:event.id)
        fill_in "Remark", with:"updated remark"
        click_button "Update"
        expect(current_path).to eq event_path(event.id)
        expect(page).to have_content "updated remark" 
      ensure
        delete :remarks
        delete :events
        delete :remarkables
        delete :universes
      end
    end
  end
 
end
