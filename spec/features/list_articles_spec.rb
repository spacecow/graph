require 'rails_helper'
require 'vcr_helper'

describe 'List articles' do

  subject{ page }

  it "list articles" do
    VCR.use_cassette('list_articles') do
      universe = create(:universe, title:'The Malazan Empire')
      create :article, name:'Kelsier', universe_id:universe.id
      visit articles_path
      is_expected.to have_content 'Kelsier'    
      delete :universes
    end
  end

end
