require 'rails_helper'
require 'vcr_helper'

describe "Update relation" do

  it "Successfully with no redirect" do
    VCR.use_cassette("update_relation_successfully_with_no_redirect") do
      begin 
        universe = create :universe
        origin = create :article, universe_id:universe.id, name:'Old origin'
        new_origin = create :article, universe_id:universe.id, name:'New origin' 
        target = create :article, universe_id:universe.id 
        mdl = create :relation, origin_id:origin.id, target_id:target.id, type:'LocatedIn'
        visit edit_relation_path mdl.id
        expect(page.find(".origin input").value).to eq origin.id.to_s
        expect(page.find ".type select option[selected]").to have_content 'Located in'
        select 'Contract on', from:'Relation'
        fill_in 'Origin', with:new_origin.id
        click_on 'Update'
        expect(current_path).to eq relation_path(mdl.id)
        expect(page).to have_content 'Contract on'
        expect(page).to have_content 'New origin'
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

  it "Successfully on target" do
    VCR.use_cassette("update_relation_successfully_on_target") do
      begin 
        universe = create :universe, title:'The Drowned World'
        origin = create :article, universe_id:universe.id, name:'Old origin'
        new_origin = create :article, universe_id:universe.id, name:'New origin' 
        target = create :article, universe_id:universe.id, name:'Old target'
        mdl = create :relation, origin_id:origin.id, target_id:target.id, type:'LocatedIn'
        visit universes_path
        click_link "The Drowned World"
        visit article_path target.id
        within('.relations.list'){ click_link 'Edit' }
        expect(page.find(".origin input").value).to eq origin.id.to_s
        expect(page.find ".type select option[selected]").to have_content 'Located in'
        select 'Contract on', from:'Relation'
        fill_in 'Origin', with:new_origin.id
        click_on 'Update'
        expect(current_path).to eq article_path(target.id)
        expect(page).to have_content 'Contracted'
        expect(page).to have_content 'New origin'
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

  it "Successfully on origin" do
    VCR.use_cassette("update_relation_successfully_on_origin") do
      begin 
        universe = create :universe, title:'The Drowned World'
        origin = create :article, universe_id:universe.id, name:'Old origin'
        target = create :article, universe_id:universe.id, name:'Old target'
        new_target = create :article, universe_id:universe.id, name:'New target'
        mdl = create :relation, origin_id:origin.id, target_id:target.id, type:'LocatedIn'
        visit universes_path
        click_link "The Drowned World"
        visit article_path origin.id
        within('.relations.list'){ click_link 'Edit' }
        expect(page.find(".target input").value).to eq target.id.to_s
        expect(page.find ".type select option[selected]").to have_content 'Located in'
        select 'Contract on', from:'Relation'
        fill_in 'Target', with:new_target.id
        click_on 'Update'
        expect(current_path).to eq article_path(origin.id)
        expect(page).to have_content 'Contract on'
        expect(page).to have_content 'New target'
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end


end
