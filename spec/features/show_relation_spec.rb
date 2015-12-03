require 'rails_helper'
require 'vcr_helper'

describe "Show relation" do

  it "displays the relation" do
    VCR.use_cassette("display_relation") do
      begin
        universe = create :universe 
        origin = create :article, universe_id:universe.id
        target = create :article, universe_id:universe.id
        relation = create :relation, origin_id:origin.id, target_id:target.id,
          type:"Husband"
        create :reference, referenceable_id:relation.id,
          referenceable_type:"Relation", comment:"once upon a time"
        visit relation_path relation.id
        expect(page).to have_content "Husband"
        expect(page).to have_content "once upon a time"
      ensure
        delete :references
        delete :relations
        delete :articles
        delete :universes
      end
    end
  end

end
