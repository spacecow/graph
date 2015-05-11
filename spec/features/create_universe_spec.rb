require 'rails_helper'
require 'vcr_helper'

describe 'Universe create' do

  subject{ page }

  context "creation successful" do
    it "" do
      VCR.use_cassette('create_universe') do
        visit new_universe_path 
        fill_in 'Title', with:'Wheel of Time'
        click_on 'Create'
        expect(current_path).to eq universes_path
        delete :universes
      end
    end

    it "" do
      VCR.use_cassette('create_universe') do
        visit new_universe_path 
        fill_in 'Title', with:'Wheel of Time'
        click_on 'Create'
        is_expected.to have_content 'Wheel of Time'
        delete :universes
      end
    end
  end

end
