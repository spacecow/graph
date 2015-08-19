require 'rails_helper'
require 'vcr_helper'

describe "Show reference" do

  it "displays the reference" do
    VCR.use_cassette("display_reference") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = create :note, article_id:article.id
        reference = create :reference, note_id:note.id
        visit reference_path reference.id
      ensure
        delete :references
        delete :notes
        delete :articles
        delete :universes
      end
    end
  end

end
