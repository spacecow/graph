require 'rails_helper'
require 'vcr_helper'

describe 'Universe index' do
  subject{ page }

  it "displays available universes" do
    VCR.use_cassette('all_universes') do
      visit universes_path
      is_expected.to have_content 'The Malazan Empire'
    end
  end

end
