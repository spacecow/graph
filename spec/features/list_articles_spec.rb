require 'rails_helper'
require 'vcr_helper'

describe 'List articles' do

  it 'unaccessible if a universe not is selected' do
    VCR.use_cassette('list_articles_is_unaccessible_if_a_universe_not_is_selected') do
      visit articles_path
      expect(current_path).to eq universes_path
    end
  end

  it 'list articles' do
    VCR.use_cassette('list_articles') do
      universe = create :universe, title:'The Malazan Empire'
      create :article, name:'Kelsier', universe_id:universe.id
      visit universes_path
      click_link 'The Malazan Empire'
      visit articles_path
      expect(page).to have_content 'Kelsier'    
      expect(current_path).to eq articles_path
      delete :articles
      delete :universes
    end
  end

  it 'navigate to the new article page' do
    VCR.use_cassette('navigate_to_the_new_article_page') do
      universe = create :universe, title:'The Malazan Empire'
      visit universes_path
      click_link 'The Malazan Empire'
      visit articles_path
      click_link 'New Article'
      expect(current_path).to eq new_article_path
      delete :universes
    end
  end

end
