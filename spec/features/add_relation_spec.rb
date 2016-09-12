require 'rails_helper'
require 'vcr_helper'

describe "Add relation" do

  context "addition successful" do
    it "" do
      VCR.use_cassette("add_relation_successfully") do
        begin
          universe = create :universe, title:"The Wheel of Time"
          visit universes_path
          click_link "The Wheel of Time"
          swordmaster = create :article, universe_id:universe.id, name:"Swordmaster"
          article = create :article, universe_id:universe.id, name:"Sword"
          visit article_path(article.id)
          expect(all(".type option").map(&:text)).to eq [
            "","Acquaintance", "Advisor", "Ancestor", "Aunt", "Betrothed", 
            "Boyfriend", "Brother", "Companion", "ContractOn", "Counselor", "Courter",
            "Cousin", "Creator", "Customer", "Employee", "Enemy", "Father", "Follower",
            "Friend", "Girlfriend", "Guide", "Hearsay", "Home", "Husband",
            "Killer", "King", "LocatedIn", "Maid", "Member", "Mother",
            "NearSister", "Owner", "Participant", "Player", "Practitioner", "Queen",
            "Resident", "RightHand", "Ruler", "Sister", "Swordbearer",
            "Teacher", "Uncle", "Variant", "Visitor", "Warder", "Wielder",
            "Worshiper"] 
          select "Owner", from:"Relation"
          fill_in "Relative", with:swordmaster.id
          within('.relation.new.form'){ click_button "Add" }
          expect(current_path).to eq article_path(article.id) 
          #TODO show relations
          expect(page.find "div.relations").to have_content 'Owner'
          expect(page.find "ul.relations").to have_content 'Swordmaster'
          expect(all(".type option").map(&:text)).to eq [
            "","Acquaintance", "Advisor", "Ancestor", "Aunt", "Betrothed", 
            "Boyfriend", "Brother", "Companion", "ContractOn", "Counselor", "Courter",
            "Cousin", "Creator", "Customer", "Employee", "Enemy", "Father", "Follower",
            "Friend", "Girlfriend", "Guide", "Hearsay", "Home", "Husband",
            "Killer", "King", "LocatedIn", "Maid", "Member", "Mother",
            "NearSister", "Owner", "Participant", "Player", "Practitioner", "Queen",
            "Resident", "RightHand", "Ruler", "Sister", "Swordbearer",
            "Teacher", "Uncle", "Variant", "Visitor", "Warder", "Wielder",
            "Worshiper"] 
        ensure
          delete :relations
          delete :articles
          tdelete :universes
        end
      end
    end
  end

end
