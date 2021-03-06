require 'rails_helper'
require 'vcr_helper'

describe "Add citation" do

  it "Successfully" do
    VCR.use_cassette("add_citation_successfully") do
      begin
        universe = create :universe, title:"The Long Earth"
        visit universes_path
        click_link "The Long Earth"
        article = create :article, universe_id:universe.id
        create :article, universe_id:universe.id, name:"Shadow World"
        visit article_path(article.id)
        fill_in "Citation", with:"It is dark"
        select "Shadow World", from:"About"
        within('.citation.new.form'){ click_button "Add" }
        expect(current_path).to eq article_path(article.id) 
        expect(page.find 'li.citation').to have_content "It is dark"
        expect(page.find 'li.citation').to have_content "Shadow World"
      ensure
        tdelete :citations
        delete :articles 
        tdelete :universes
      end
    end
  end

end
