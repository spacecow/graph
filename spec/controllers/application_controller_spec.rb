describe "ApplicationController" do

  let(:controller){ ApplicationController.new }
  
  before do
    require 'controller_helper'
    require './app/controllers/application_controller'
  end

  describe "#current_universe_id" do
    let(:function){ controller.current_universe_id *current_universe_id }

    before do
      def controller.session; end
      expect(controller).to receive(:session){ {current_universe_id:666} }
    end

    subject{ function }

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
