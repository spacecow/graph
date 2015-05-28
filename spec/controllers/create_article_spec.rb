#describe "ArticlesController#create" do
#  
#  let(:controller){ ArticlesController.new }
#
#  before do
#    stub_const "ArticleRunners::Create", Class.new
#    require 'controller_helper'
#    require './app/controllers/articles_controller'
#  end
#
#  describe "#create" do
#    before do
#      expect(controller).to receive(:restrict_access)
#      controller.create
#    end
#
#    it{ subject }
#  end
#
#end
