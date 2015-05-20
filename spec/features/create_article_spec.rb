require 'rails_helper'

describe "Create article" do
  
  subject{ page }

  context "creation successful" do
    it "" do
      visit new_article_path
      fill_in 'Name', with:'Kelsier'
    end
  end

end
