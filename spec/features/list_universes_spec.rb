require 'rails_helper'
require 'vcr_helper'

describe "List universes" do

  it "Displays available universes" do
    VCR.use_cassette('displays_available_universes') do
      begin
        create :universe, title:'The Malazan Empire'
        visit universes_path
        expect(page).to have_content 'The Malazan Empire'
      ensure
        delete :universes
      end
    end
  end

  it 'select a universe' do
    VCR.use_cassette('select_a_universe') do
      begin
        create :universe, title:'The Malazan Empire'
        visit universes_path
        click_link 'The Malazan Empire'
        visit universes_path
        expect(find('.selected .title').text).to eq 'The Malazan Empire'
      ensure
        delete :universes
      end
    end
  end

  it 'list articles within the universe' do
    VCR.use_cassette('list_articles_within_the_universe') do
      begin
        universe = create :universe, title:'The Malazan Empire'
        visit universes_path
        click_link 'The Malazan Empire'
        expect(current_path).to eq universe_path(universe.id) 
      ensure
        delete :universes
      end
    end
  end


  it 'navigate to the new universe page' do
    VCR.use_cassette('navigate_to_the_new_universe_page') do
      visit universes_path
      click_link 'New Universe'
      expect(current_path).to eq new_universe_path
    end
  end

end
