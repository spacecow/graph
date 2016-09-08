require 'rails_helper'
require 'vcr_helper'

describe "Update relation" do

  it "Successfully" do
    VCR.use_cassette("update_relation_successfully") do
      begin 
        universe = create :universe
        origin = create :article, universe_id:universe.id 
        target = create :article, universe_id:universe.id 
        mdl = create :relation, origin_id:origin.id, target_id:target.id, type:'LocatedIn'
        visit edit_relation_path(mdl.id)
        expect(page.find ".type select option[selected]").to have_content 'Located in'
        select 'Contract on', from:'Relation'
        click_on 'Update'
        expect(page.find ".type select option[selected]").to have_content 'Contract on'
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

end
