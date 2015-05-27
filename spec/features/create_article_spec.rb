require 'rails_helper'
require 'vcr_helper'

describe "Create article" do
  
  let(:error_field){ '.name .errors' }

  context "creation successful" do
    it "" do
      VCR.use_cassette('create_article_successfully') do
        begin 
          universe = create :universe, title:'The Malazan Empire'
          visit universes_path
          click_link 'The Malazan Empire'
          visit new_article_path
          expect(page).not_to have_selector error_field 
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

  context "creation failure" do
    it "" do
      VCR.use_cassette('create_article_with_failures') do
        begin 
          universe = create :universe, title:'The Malazan Empire'
          visit universes_path
          click_link 'The Malazan Empire'
          visit new_article_path
          fill_in 'Name', with:''
          select 'Character', from:'Type'
          click_on 'Create'
          expect(current_path).to eq articles_path
          expect(page.find(error_field).text).to eq 'cannot be blank'
        ensure
          delete :universes
        end
      end
    end
  end

end
