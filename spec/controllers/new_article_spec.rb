describe "ArticlesController#new" do

  let(:controller){ ArticlesController.new }

  before do
    require 'controller_helper'
    require './app/controllers/articles_controller'
  end

  describe "#new" do
    before do
      module ArticleRunners
        class New; end 
      end unless defined?(ArticleRunners::New)
      expect(controller).to receive(:run).with(ArticleRunners::New){ :article } 
      controller.new
    end

    describe "@article" do
      subject{ controller.instance_variable_get(:@article) }
      it{ is_expected.to be :article }
    end 
  end

end
