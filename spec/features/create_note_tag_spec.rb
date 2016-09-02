require 'rails_helper'
require 'vcr_helper'

describe "Create note tag" do

  it "Successfully" do
    VCR.use_cassette("create_note_tag_successfully") do
      begin
        universe = create :universe, title:"Computer World"
        article = create :article, universe_id:universe.id
        noting = tcreate :article_note, article_id:article.id
        tag = tcreate :tag, title:'TDP', universe_id:universe.id
        visit universes_path
        click_link "Computer World"
        visit note_path noting.note_id
        fill_in 'Tag', with:tag.id
        click_on 'Create Tagging'
        expect(current_path).to eq note_path(noting.note_id)
        expect(page.find('li.tag')).to have_content "TDP" 
      ensure
        tdelete :article_notes
        tdelete :tags
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
