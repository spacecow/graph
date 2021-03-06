require 'rails_helper'
require 'vcr_helper'

describe "Create article tag" do

  it "Successfully" do
    VCR.use_cassette("create_article_tag_successfully") do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        article = create :article, universe_id:universe.id
        tag = tcreate :tag, title:"Aes Sedai", universe_id:universe.id
        visit article_path(article.id)
        fill_in "Tag", with: tag.id
        click_on 'Create Tagging'
        expect(current_path).to eq article_path(article.id)
        expect(page.find('li.tag')).to have_content "Aes Sedai" 
      ensure
        tdelete :tags
        delete :articles
        tdelete :universes 
      end
    end
  end
end
