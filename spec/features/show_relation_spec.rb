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

  it "navigate to the origin article", focus:true do
    VCR.use_cassette("navigate_to_origin_article") do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        origin = create :article, universe_id:universe.id, name:"The Wife",
          gender:'f'
        target = create :article, universe_id:universe.id
        relation = create :relation, origin_id:origin.id, target_id:target.id,
          type:"Husband"
        visit relation_path relation.id
        within('.origin.female'){ click_link "The Wife" }
        expect(current_path).to eq article_path(origin.id)
      ensure
        delete :relations
        delete :articles
        delete :universes
      end
    end
  end

  it "navigate to the target article", focus:true do
    VCR.use_cassette("navigate_to_target_article") do
      begin
        universe = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "The Wheel of Time"
        origin = create :article, universe_id:universe.id
        target = create :article, universe_id:universe.id, name:"The Husband",
          gender:'m'
        relation = create :relation, origin_id:origin.id, target_id:target.id,
          type:"Husband"
        visit relation_path relation.id
        within('.target.male' ){ click_link "The Husband" }
        expect(current_path).to eq article_path(target.id)
      ensure
        delete :relations
        delete :articles
        delete :universes
      end
    end
  end

end
