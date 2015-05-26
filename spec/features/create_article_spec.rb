require 'rails_helper'
require 'vcr_helper'

describe "Create article" do
  
  context "creation successful" do
    it "" do
      VCR.use_cassette('create_article') do
        begin 
          universe = create :universe, title:'The Malazan Empire'
          visit universes_path
          click_link 'The Malazan Empire'
          visit new_article_path
          fill_in 'Name', with:'Kelsier'
          select 'Character', from:'Type'
          click_on 'Create'
          expect(current_path).to eq universe_path(universe.id)
          expect(page).to have_content 'Kelsier' 
        ensure
          delete :articles
          delete :universes
        end
      end
    end
  end

end
