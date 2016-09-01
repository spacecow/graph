require 'rails_helper'
require 'vcr_helper'

describe "List tags" do

  it "Displays available tags without universe is set"do
    VCR.use_cassette('displays_available_tags') do
      begin
        tcreate :tag, title:'neuronnät' 
        visit universes_path
        click_link "Tags"
        expect(page).to have_content 'neuronnät'
      ensure
        tdelete :tags
      end
    end
  end

  it "Navigate to the new tag page" do
    VCR.use_cassette('navigate_to_the_new_tag_page') do
      visit universes_path
      click_link "Tags"
      click_link "New Tag"
      expect(current_path).to eq new_tag_path
    end
  end

end
