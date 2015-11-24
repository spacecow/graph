require 'rails_helper'
require 'vcr_helper'

describe "Show event" do

  it "display event with parent and participants" do
    VCR.use_cassette("display_event") do
      begin
        universe = create :universe, title:"Game of Thrones"
        visit universes_path
        click_link "Game of Thrones"
        parent = create :event, universe_id:universe.id, title:"Green wedding"
        event = create :event, universe_id:universe.id, title:"Red wedding",
          parent_id:parent.id
        article = create :article, universe_id:universe.id, name:"John Snow"
        create :participation, article_id:article.id, event_id:event.id
        #TODO event and article should be in the same universe!
        visit event_path event.id
        expect(page).to have_content "Green wedding"
        expect(page).to have_content "Red wedding"
        expect(page).to have_content "John Snow"
      ensure
        delete :participations
        delete :articles
        delete :events
        delete :universes
      end
    end
  end

end
