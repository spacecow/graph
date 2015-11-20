require 'rails_helper'
require 'vcr_helper'

describe "Show tag" do

  it "displays tagged notes after title" do
    VCR.use_cassette("display_tag") do
      begin
        tag = create :tag, title:'TDP'
        visit tag_path tag.id
        expect(page).to have_content 'TDP'
      ensure
        delete :tags
      end
    end
  end

end
