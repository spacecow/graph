require 'rails_helper'

describe 'Universe index' do
  before{ visit universes_path }
  subject{ page }
  it{ is_expected.to have_content 'The Malazan Empire' }
end
