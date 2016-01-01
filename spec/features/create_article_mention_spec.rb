require 'rails_helper'
require 'vcr_helper'

describe "Create article mention" do

  it "Successfully" do
    VCR.use_cassette("create_article_mention_successfully") do
      begin
        event = tcreate :event
        visit universes_path
        click_link event.universe_title
        create :article, name:"Blue wife", universe_id:event.universe_id
        visit event_path event.id
        within('.mention.article.new.form'){ fill_in "Comment", with:"an article mention" }
        within('.mention.article.new.form'){ select "Blue wife", from:"Mention" }
        within('.mention.article.new.form'){ click_button "Create" }
        expect(current_path).to eq event_path(event.id) 
        expect(page.find 'li.mention.article').to have_content "Blue wife"
        expect(page.find 'li.mention.article').to have_content "an article mention"
      ensure
        tdelete :article_mentions
        tdelete :events
        delete :articles
        tdelete :universes 
      end
    end
  end

end
