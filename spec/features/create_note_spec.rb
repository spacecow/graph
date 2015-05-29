require 'rails_helper'
require 'vcr_helper'

describe "Create note" do

  describe "creation successful" do
    
    it "" do
      VCR.use_cassette("create_note_successfully") do
        begin
          universe = create :universe, title:'The Malazan Empire'
          create :book, title:'Cryptonomicon', universe_id:universe.id
          visit universes_path
          click_link 'The Malazan Empire'
          visit new_note_path
          select 'Cryptonomicon', from:'Book'
          click_on 'Create'
        ensure
          delete :books
          delete :universes
        end
      end
    end

  end

end
