require 'rails_helper'
require 'vcr_helper'

describe "Create note" do

  describe "creation successful" do
    it "" do
      VCR.use_cassette("create_tag_successfully") do
        begin
          universe = create :universe, title:"Game of Thrones"
          visit universes_path
          click_link "Game of Thrones"
          visit new_tag_path
          fill_in 'Title', with:'TDP'
          click_on 'Create'
          expect(current_path).to eq tags_path
          expect(page).to have_content 'TDP' 
        ensure
          tdelete :tags
        end
      end
    end
  end
  
end
