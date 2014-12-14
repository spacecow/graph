require 'rails_helper'

describe 'Universe create' do

  before do
    visit new_universe_path 
    fill_in 'Title', with:'Wheel of Time'
    click_on 'Create'
  end

  subject{ page }

  #context "creation successful" do
  #  its(:current_path){ is_expected.to eq universes_path }
  #  it{ is_expected.to have_content 'Wheel of Time' }
  #end

end
