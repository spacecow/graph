require 'rails_helper'
require 'vcr_helper'

describe "Show reference" do

  it "displays the reference" do
    VCR.use_cassette("display_reference") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = tcreate :note
        reference = create :reference, referenceable_id:note.id,
          referenceable_type:"Note"
        visit reference_path reference.id
      ensure
        tdelete :article_notes
        delete :references
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
