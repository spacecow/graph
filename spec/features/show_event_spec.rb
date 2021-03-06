require 'rails_helper'
require 'vcr_helper'

describe "Show event" do

  #content does not seem to work for mentions
  it "display event with parent and participants" do
    VCR.use_cassette("display_event") do
      begin
        universe = create :universe, title:"Game of Thrones"
        visit universes_path
        click_link "Game of Thrones"
        parent = tcreate :event, universe_id:universe.id, title:"Green wedding"
        event = tcreate :event, universe_id:universe.id, title:"Red wedding"
        blue = tcreate :event, universe_id:universe.id, title:"Blue wedding"
        yellow = tcreate :event, universe_id:universe.id, title:"Yellow wedding"
        note = tcreate :note, text:'a note'
        tcreate :event_note, event_id:event.id, note_id:note.id
        create :step, parent_id:parent.id, child_id:event.id
        article = create :article, universe_id:universe.id, name:"John Snow",
          gender:'m'
        create :participation, participant_id:article.id, event_id:event.id
        tcreate :mention, origin_id:event.id, target_id:blue.id,
          content:"all blue"
        kuk = tcreate :mention, origin_id:yellow.id, target_id:event.id,
          content:"all yellow"
        blue_wife = create :article, universe_id:universe.id, name:"Blue wife",
          gender:'f'
        tcreate :article_mention, origin_id:event.id, target_id:blue_wife.id,
          content:"all blue"
        #TODO event and article should be in the same universe!
        visit event_path event.id
        expect(page.find 'ul.parents').to have_content "Green wedding"
        expect(page.find 'h1').to have_content "Red wedding"
        expect(page).to have_content "a note"
        expect(page.find 'ul.mentions.events.direct').to have_content "Blue wedding"
        expect(page.find 'ul.mentions.events.direct').not_to have_content "Blue wedding - all blue"
        expect(page.find 'ul.mentions.events.inverse').to have_content "Yellow wedding"
        expect(page.find 'ul.mentions.events.inverse').not_to have_content "Yellow wedding - all yellow"
        expect(page.find 'ul.mentions.articles.direct').to have_content(
          "Blue wife - all blue")
        expect(page.find '.participations .male').to have_content "John Snow"
        expect(all(".parent form option").map(&:text)).to eq [""]
        expect(all(".mention.event form option").map(&:text)).to eq [""]
      ensure
        tdelete :article_mentions
        tdelete :mentions
        tdelete :event_notes
        delete :notes
        delete :steps
        tdelete :participations
        delete :articles
        tdelete :events
        tdelete :universes
      end
    end
  end

  it "navigate to a mentioned event page" do
    VCR.use_cassette('navigate_to_a_mentioned_event_page') do
      begin
        event = tcreate :event
        blue = tcreate :event, title:"Blue wedding"
        tcreate :mention, origin_id:event.id, target_id:blue.id
        visit universes_path
        click_link event.universe_title
        visit event_path event.id
        within('li.mention'){ click_link "Blue wedding" }
        expect(current_path).to eq event_path(blue.id)
      ensure
        tdelete :mentions
        tdelete :events
        tdelete :universes 
      end
    end
  end


  it "navigate to a participant page" do
    VCR.use_cassette('navigate_to_a_participant_page') do
      begin
        event = tcreate :event
        article = create :article, name:"Ethenielle", universe_id:event.universe_id
        visit universes_path
        click_link event.universe_title
        tcreate :participation, event_id:event.id, participant_id:article.id
        visit event_path event.id
        click_link "Ethenielle"
        expect(current_path).to eq article_path(article.id)
      ensure
        tdelete :participations
        delete :articles
        tdelete :events
        tdelete :universes 
      end
    end
  end


end
