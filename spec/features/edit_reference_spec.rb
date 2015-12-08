require 'rails_helper'
require 'vcr_helper'

describe "Edit reference" do

  describe "Successfully" do
    it "" do
      VCR.use_cassette("update_reference_successfully") do
        begin
          universe = create :universe
          article = create :article, universe_id:universe.id
          note = create :note, article_id:article.id
          reference = create :reference, referenceable_id:note.id,
            referenceable_type:"Note"
          visit edit_reference_path reference.id
          attach_file('Image', Rails.root + 'spec/pear.jpeg')
          fill_in 'Comment', with:'smart'
          fill_in 'Url', with:'www.example.com'
          click_on 'Update'
          expect(current_path).to eq reference_path(reference.id)
          expect(page).to have_content 'smart' 
        ensure
          delete :references
          delete :notes
          delete :articles
          tdelete :universes
        end
      end
    end
  end

end
