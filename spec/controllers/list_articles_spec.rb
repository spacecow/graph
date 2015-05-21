describe 'ArticlesController#index' do

  let(:controller){ ArticlesController.new }

  before do
    stub_const "ArticleRunners::Index", Class.new
    require 'controller_helper'
    require './app/controllers/articles_controller'
  end

  describe '#index' do
    before do
      expect(controller).to receive(:run).with(ArticleRunners::Index){ :articles }
      controller.index
    end

    describe '@articles' do
      subject{ controller.instance_variable_get(:@articles) }
      it{ is_expected.to be :articles }
    end
  end

end
