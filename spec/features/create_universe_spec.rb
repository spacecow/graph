require 'rails_helper'
require 'vcr_helper'

describe 'Create universe' do

  let(:error_field){ '.title .errors' }

  context "creation successful" do
    it "" do
      VCR.use_cassette('create_universe_successfully') do
        visit new_universe_path 
        fill_in 'Title', with:'Wheel of Time'
        click_on 'Create'
        expect(current_path).to eq universes_path
        expect(page).to have_content 'Wheel of Time'
        delete :universes
      end
    end
  end

  context "creation failure" do
    it "title must be unique" do
      VCR.use_cassette('create_universe_with_uniqueness_violation') do
        begin
          create :universe, title:'Wheel of Time'
          visit new_universe_path 
          fill_in 'Title', with:'Wheel of Time'
          click_on 'Create'
          expect(current_path).to eq universes_path
          expect(page.find(error_field).text).to eq 'must be unique'
        ensure
          delete :universes
        end
      end
    end
  end

end
