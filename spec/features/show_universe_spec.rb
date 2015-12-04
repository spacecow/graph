require 'rails_helper'
require 'vcr_helper'

describe 'Show universe' do

  it "displays the universe with its articles" do
    VCR.use_cassette("display_universe_with_articles") do
      begin
        universe = create :universe, title:'The Final Empire'
        article = create :article, name:'Kelsier', type:'Character',
          universe_id:universe.id, gender:'m'
        visit universe_path universe.id
        expect(current_path).to eq universe_path(universe.id)
        expect(page).to have_content 'The Final Empire'
        expect(page.find '.male').to have_content 'Kelsier'
      ensure
        delete :articles
        delete :universes
      end
    end
  end

  it 'navigate to an article page' do
    VCR.use_cassette('navigate_to_an_article_page') do
      begin
        universe = create :universe
        article = create :article, name:'Kelsier', universe_id:universe.id
        visit universe_path universe.id
        click_link 'Kelsier'
        expect(current_path).to eq article_path(article.id)
      ensure
        delete :articles
        delete :universes
      end
    end
  end

  it 'navigate to the new article page' do
    VCR.use_cassette('navigate_to_the_new_article_page') do
      begin
        universe = create :universe
        visit universe_path(universe.id)
        click_link 'New Article'
        expect(current_path).to eq new_article_path
      ensure
        delete :universes
      end
    end
  end

end
