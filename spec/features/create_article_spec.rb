require 'rails_helper'
require 'vcr_helper'

describe "Create article" do
  
  let(:name_error_field){ '.name .errors' }
  let(:type_error_field){ '.type .errors' }

  context "creation successful" do
    it "" do
      VCR.use_cassette('create_article_successfully') do
        begin 
          universe = create :universe, title:'The Malazan Empire'
          visit universes_path
          click_link 'The Malazan Empire'
          visit new_article_path
          expect(page).not_to have_selector name_error_field 
          expect(page).not_to have_selector type_error_field 
          expect(all(".type select option").map(&:text)).to eq([
            "", "Affiliation", "Character", "Family", "Item", "Location",
            "Magician", "Profession", "Race", "Relic", "Religion", "Society",
            "Source", "Structure"])
          fill_in 'Name', with:'Kelsier'
          select 'Character', from:'Type'
          click_on 'Create'
          expect(current_path).to match /articles\/\d+/
          expect(page).to have_content 'Kelsier' 
        ensure
          delete :articles
          tdelete :universes
        end
      end
    end
  end

  context "creation failure" do
    it "title cannot be blank" do
      VCR.use_cassette('create_article_with_blank_title_violation') do
        begin 
          universe = create :universe, title:'The Malazan Empire'
          visit universes_path
          click_link 'The Malazan Empire'
          visit new_article_path
          fill_in 'Name', with:''
          select 'Character', from:'Type'
          click_on 'Create'
          expect(current_path).to eq articles_path
          expect(page.find(name_error_field).text).to eq 'cannot be blank'
          expect(all(".type select option").map(&:text)).to eq([
            "", "Affiliation", "Character", "Family", "Item", "Location",
            "Magician", "Profession", "Race", "Relic", "Religion", "Society",
            "Source", "Structure"])
        ensure
          tdelete :universes
        end
      end
    end
  end

  context "creation failure" do
    it "type cannot be blank" do
      VCR.use_cassette('create_article_with_blank_type_violation') do
        begin 
          universe = create :universe, title:'The Malazan Empire'
          visit universes_path
          click_link 'The Malazan Empire'
          visit new_article_path
          fill_in 'Name', with:'Kelsier'
          select '', from:'Type'
          click_on 'Create'
          expect(current_path).to eq articles_path
          expect(page.find(type_error_field).text).to eq 'cannot be blank'
        ensure
          tdelete :universes
        end
      end
    end

  end
end
