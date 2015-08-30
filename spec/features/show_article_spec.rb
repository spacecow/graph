require 'rails_helper'
require 'vcr_helper'

describe 'Show article' do

  it "displays the article with its notes" do
    VCR.use_cassette("display_article_with_notes") do
      begin
        universe = create :universe, title:'The Final Empire'
        article = create :article, name:'Kelsier', universe_id:universe.id, type:'Character'
        note = create :note, article_id:article.id, text:'a note'
        tag = create :tag, title:'hero'
        create :tagging, tag_id:tag.id, tagable_id:note.id, tagable_type:'Note'
        visit article_path article.id
        expect(current_path).to eq article_path(article.id)
        expect(page).to have_content 'Kelsier'
        expect(page).to have_content 'a note'
        expect(page).to have_content 'hero'
      ensure
        delete :taggings
        delete :tags
        delete :notes
        delete :articles
        delete :universes
      end
    end
  end

  it "navigate to a note page" do
    VCR.use_cassette('navigate_to_a_note_page') do
      begin
        universe = create :universe
        article = create :article, name:'Kelsier', universe_id:universe.id, type:'Character'
        note = create :note, article_id:article.id, text:'a note'
        visit article_path article.id
        click_link 'a note'
        expect(current_path).to eq note_path(note.id)
      ensure
        delete :notes
        delete :articles
        delete :universes
      end
    end
  end

end
