require 'rails_helper'
require 'vcr_helper'

describe "Edit note" do

  it "Updated" do
    VCR.use_cassette('edit_article_successfully') do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time" 
        article = create :article, universe_id:universe.id, name:"old name"
        visit edit_article_path article.id
        expect(current_path).to eq edit_article_path(article.id)
        fill_in 'Name', with:"updated name"
        select 'Female', from:"Gender"
        click_on 'Update'
        expect(current_path).to eq article_path(article.id)
        expect(page).to have_content 'updated name' 
      ensure
        delete :articles
        tdelete :universes
      end
    end
  end

end
