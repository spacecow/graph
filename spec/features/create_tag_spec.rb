require 'rails_helper'
require 'vcr_helper'

describe "Create tag" do

  context "Filled in correctly" do
    it "Creates a tag" do
      VCR.use_cassette("create_tag_successfully") do
        begin
          universe = create :universe, title:"Machine Learning A"
          visit universes_path
          click_link "Machine Learning A"
          visit new_tag_path
          fill_in 'Title', with:'TDP'
          click_on 'Create'
          expect(current_path).to eq tags_path
          expect(page).to have_content 'TDP' 
        ensure
          tdelete :tags
          tdelete :universes
        end
      end
    end
  end

  context "Filled in incorrectly" do
    it "Param title is duplicated" do
      VCR.use_cassette("creation_of_tag_failing_with_duplicated_title") do
        begin
          universe = create :universe, title:"Machine Learning B"
          tcreate :tag, title:'TDP', universe_id:universe.id 
          visit universes_path
          click_link "Machine Learning B"
          visit new_tag_path
          fill_in 'Title', with:'TDP'
          click_on 'Create'
          expect(current_path).to eq tags_path
          expect(page.find('.title .errors').text).to eq 'is already taken'
        ensure
          tdelete :tags
          tdelete :universes
        end
      end
    end
  end
  
end
