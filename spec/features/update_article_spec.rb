require 'rails_helper'
require 'vcr_helper'

describe "Update article" do

  it "Successfully" do
    VCR.use_cassette("update_article_successfully") do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time" 
        article = create :article, universe_id:universe.id, name:"an old name"
        visit edit_article_path article.id
        expect(current_path).to eq edit_article_path(article.id)
        fill_in 'Name', with:"an updated name"
        select 'Female', from:"Gender"
        click_on 'Update'
        expect(current_path).to eq article_path(article.id)
        expect(page).to have_content "an updated name" 
      ensure
        delete :articles
        tdelete :universes
      end
    end
  end

end
