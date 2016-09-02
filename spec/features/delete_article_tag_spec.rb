require 'rails_helper'
require 'vcr_helper'

describe "Delete article tag" do
  it "Successfully" do
    VCR.use_cassette("delete_article_tag_successfully") do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        article = create :article, universe_id:universe.id
        tcreate :tag, tagable_id:article.id, tagable_type:'Article', universe_id:universe.id
        visit article_path article.id
        within('li.tag'){ click_link "Delete" }
        expect(current_path).to eq article_path(article.id)
        expect(page).not_to have_selector 'li.tag'
      ensure
        tdelete :tags
        delete :articles
        tdelete :universes
      end
    end
  end
end
