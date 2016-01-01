require 'rails_helper'
require 'vcr_helper'

describe "Update article note" do

  it "Successfully" do
    VCR.use_cassette('update_participation_successfully') do
      begin
        event = tcreate :event
        visit universes_path
        click_link event.universe_title
        article = create :article, universe_id:event.universe_id
        participation = create :participation, participant_id:article.id,
          event_id:event.id
        visit event_path event.id
        within('li.participation'){ click_link "Edit" }
        expect(current_path).to eq edit_participation_path(participation.id)
        fill_in "Comment", with:"extremely blue"
        click_on "Update"
        expect(current_path).to eq event_path(event.id)
        expect(page.find('li.participation')).to have_content "extremely blue"
      ensure
        tdelete :participations
        delete :articles
        tdelete :events
        tdelete :universes
      end
    end
  end

end
