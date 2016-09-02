require 'rails_helper'
require 'vcr_helper'

describe "List tags" do

  it "Displays available tags"do
    VCR.use_cassette('displays_available_tags') do
      begin
        universe = create :universe, title:"Machine Learning A"
        visit universes_path
        click_link "Machine Learning A"
        tag = tcreate :tag, title:'neuronnät', universe_id:universe.id 
        visit universes_path
        click_link "Tags"
        expect(page).to have_content 'neuronnät'
      ensure
        tdelete :tags
        tdelete :universes
      end
    end
  end

  it "Displays available tags tied to universe"do
    VCR.use_cassette('displays_available_tags_tied_to_universe') do
      begin
        universe = create :universe, title:"Machine Learning B"
        universe2 = create :universe, title:"The Wheel of Time"
        visit universes_path
        click_link "Machine Learning B"
        tcreate :tag, title:'neuronnät', universe_id:universe.id 
        tcreate :tag, title:'Rand', universe_id:universe2.id 
        visit universes_path
        click_link "Tags"
        expect(page).to have_content 'neuronnät'
        expect(page).not_to have_content 'Rand'
      ensure
        tdelete :tags
        tdelete :universes
      end
    end
  end


  it "Navigate to the new tag page" do
    VCR.use_cassette('navigate_to_the_new_tag_page') do
      begin
        universe = create :universe, title:"Machine Learning C"
        visit universes_path
        click_link "Machine Learning C"
        click_link "Tags"
        click_link "New Tag"
        expect(current_path).to eq new_tag_path
      ensure
        tdelete :universes
      end
    end
  end

end
