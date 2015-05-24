require 'rails_helper'
require 'vcr_helper'

describe 'Show universe' do

  let(:universe){ create :universe, title:'The Final Empire' }

  it "" do
    VCR.use_cassette("show_universe") do
      begin
        universe
        visit universe_path(universe.id)
        expect(current_path).to eq universe_path(universe.id)
        expect(page).to have_content 'The Final Empire'
      ensure
        delete :universes
      end
    end
  end

end
