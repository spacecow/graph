describe "ApplicationController" do

  let(:controller){ ApplicationController.new }
  
  before do
    require 'controller_helper'
    require './app/controllers/application_controller'
  end

  describe "#current_universe_id" do
    before{ controller.instance_variable_set :@current_universe_id, 666 }
    subject{ controller.current_universe_id *current_universe_id }

    context "get the value" do
      let(:current_universe_id){ [] }
      it{ is_expected.to eq 666 }
    end

    context "set the value" do
      let(:current_universe_id){ ["888"] }
      it{ is_expected.to eq 888 }
    end
  end

end
