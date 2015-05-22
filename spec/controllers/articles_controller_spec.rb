describe "ArticlesController" do

  let(:controller){ ArticlesController.new }

  before do
    stub_const "ArticleRunners", Module.new
    require 'controller_helper'
    require './app/controllers/articles_controller'
  end

  describe "#restrict_access" do
    let(:current_universe_id){ nil }

    before do
      expect(controller).to receive(:current_universe_id){ current_universe_id }
    end

    subject{ controller.send(:restrict_access) }
    context "no universe is selected" do
      before do
        def controller.universes_path; end
        def controller.redirect_to a; end
        expect(controller).to receive(:universes_path){ :universes_path }
        expect(controller).to receive(:redirect_to).with(:universes_path)
      end
      it{ is_expected.to be nil }
    end
    context "a universe is selected" do
      let(:current_universe_id){ 666 }
      it{ is_expected.to be nil }
    end
  end

end
