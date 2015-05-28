describe "ArticlesController#new" do

  let(:controller){ ArticlesController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ArticleRunners::New", Class.new
    require 'controller_helper'
    require './app/controllers/articles_controller'
  end

  describe "#new" do
    before do
      expect(controller).to receive(:restrict_access)
      expect(controller).to receive(:run).with(ArticleRunners::New){ :article } 
      expect(controller).to receive(:repo){ repo }
      expect(repo).to receive(:article_types){ :article_types }
      controller.new
    end

    describe "@article" do
      subject{ controller.instance_variable_get(:@article) }
      it{ is_expected.to be :article }
    end 

    describe "@article_types" do
      subject{ controller.instance_variable_get(:@article_types) }
      it{ is_expected.to be :article_types }
    end 
  end

end
