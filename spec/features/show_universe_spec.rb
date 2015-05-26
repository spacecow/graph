require 'rails_helper'
require 'vcr_helper'

describe 'Show universe' do


  it "displays the universe with it's articles" do
    VCR.use_cassette("display_universe_with_articles") do
      begin
        universe = create :universe, title:'The Final Empire'
        create :article, name:'Kelsier', type:'Character', universe_id:universe.id
        visit universe_path(universe.id)
        expect(current_path).to eq universe_path(universe.id)
        expect(page).to have_content 'The Final Empire'
        expect(page).to have_content 'Kelsier'
      ensure
        delete :articles
        delete :universes
      end
    end
  end

  it 'navigate to the new article page' do
    VCR.use_cassette('navigate_to_the_new_article_page') do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universe_path(universe.id)
        click_link 'New Article'
        expect(current_path).to eq new_article_path
      ensure
        delete :universes
      end
    end
  end

end
