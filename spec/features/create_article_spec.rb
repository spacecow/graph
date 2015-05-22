require 'rails_helper'
require 'vcr_helper'

describe "Create article" do
  
  context "creation successful" do
    it "" do
      VCR.use_cassette('create_article') do
        universe = create :universe, title:'The Malazan Empire'
        visit universes_path
        click_link 'The Malazan Empire'
        visit new_article_path
        fill_in 'Name', with:'Kelsier'
        click_on 'Create'
        expect(current_path).to eq articles_path
        expect(page).to have_content 'Kelsier' 
        delete :articles
        delete :universe
      end
    end
  end

end
