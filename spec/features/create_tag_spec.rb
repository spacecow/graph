require 'rails_helper'
require 'vcr_helper'

describe "Create note" do

  describe "creation successful" do
    it "" do
      VCR.use_cassette("create_tag_successfully") do
        begin
          visit new_tag_path
          fill_in 'Title', with:'TDP'
          click_on 'Create'
          expect(current_path).to eq tags_path
          expect(page).to have_content 'TDP' 
        ensure
          delete :tags
        end
      end
    end
  end
  
end
