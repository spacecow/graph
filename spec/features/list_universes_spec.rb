require 'rails_helper'
require 'vcr_helper'

describe 'Universe index' do
  subject{ page }

  it "displays available universes" do
    VCR.use_cassette('all_universes') do
      create :universe, title:'The Malazan Empire'
      visit universes_path
      is_expected.to have_content 'The Malazan Empire'
      delete :universes
    end
  end

  it "select a universe" do
    VCR.use_cassette('all_universes_with_redirect') do
      create :universe, title:'The Malazan Empire'
      visit universes_path
      click_link 'The Malazan Empire'
      delete :universes
    end
  end

  it "navigate to the new universe page" do
    VCR.use_cassette('all_universes') do
      visit universes_path
      click_link 'New Universe'
    end
  end

end
