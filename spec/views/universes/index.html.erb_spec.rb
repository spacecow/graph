require 'view_helper'
require 'capybara'

describe 'universes/index.html.erb' do

  let(:file){ 'universes/index.html.erb' }
  
  before{|example| render_view file:file }

  subject(:universes){ Capybara.string(rendering).find('.universes') }
  
  context "one universe" do
    describe "rendered universes" do 
      subject{ universes.all('.universe') }
      its(:count){ should be 1 }
    end
    describe "rendered universe" do
      subject{ universes.find('.universe') }
      its(:text){ is_expected.to include 'The Malazan Empire' }
    end
  end
end
