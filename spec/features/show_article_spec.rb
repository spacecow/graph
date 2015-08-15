require 'rails_helper'
require 'vcr_helper'

describe 'Show article' do

  it "displays the article with its notes" do
    VCR.use_cassette("display_article_with_notes") do
      begin
        universe = create :universe, title:'The Final Empire'
        universe_id = universe.id
        article = create :article, name:'Kelsier', universe_id:universe_id, type:'Character'
        article_id = article.id
        create :note, article_id:article_id, text:'a note'
        visit article_path article_id
        expect(current_path).to eq article_path(article_id)
        expect(page).to have_content 'Kelsier'
        expect(page).to have_content 'a note'
      ensure
        delete :notes
        delete :articles
        delete :universes
      end
    end
  end

end
