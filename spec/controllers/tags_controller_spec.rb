describe "TagsController" do

  let(:controller){ TagsController.new }

  before do
    stub_const "ApplicationController", Class.new
    require './app/controllers/tags_controller'
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    it{ subject }
  end

end
