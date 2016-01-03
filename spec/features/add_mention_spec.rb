require 'rails_helper'
require 'vcr_helper'

describe "Add mention" do

  it "Successfully" do
    VCR.use_cassette("add_mention_successfully") do
      begin
        event = tcreate :event
        tcreate :event, title:"Blue wedding", universe_id:event.universe_id
        visit universes_path
        click_link event.universe_title
        visit event_path event.id
        within('.mention.event.new.form'){ fill_in "Comment", with:"a comment" }
        within('.mention.event.new.form'){ select "Blue wedding", from:"Mention" }
        within('.mention.event.new.form'){ click_button "Add" }
        expect(current_path).to eq event_path(event.id) 
        expect(page.find 'li.mention.event').to have_content(
          "Blue wedding - a comment")
      ensure
        tdelete :mentions
        tdelete :events
        tdelete :universes
      end
    end
  end

end
