require 'rails_helper'
require 'vcr_helper'

describe "Update article note" do

  it "Successfully" do
    VCR.use_cassette('update_article_mention_successfully') do
      begin
        event = tcreate :event
        visit universes_path
        click_link event.universe_title
        target = create :article, universe_id:event.universe_id, name:"Blue wife"
        mention = tcreate :article_mention, origin_id:event.id,
          target_id:target.id, content:"very blue"
        visit event_path event.id
        within('li.mention.article'){ click_link "very blue" }
        expect(current_path).to eq edit_article_mention_path(mention.id)
        fill_in "Comment", with:"extremely blue"
        click_on "Update"
        expect(current_path).to eq event_path(event.id)
        expect(page.find('li.mention.article')).to have_content "extremely blue"
      ensure
        tdelete :article_mentions
        tdelete :events
        delete :articles
        tdelete :universes 
      end
    end
  end

end
