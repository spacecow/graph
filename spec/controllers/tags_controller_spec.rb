describe "TagsController" do

  let(:controller){ TagsController.new }

  before do
    stub_const "TagRunners::Show", Class.new
    stub_const "ApplicationController", Class.new
    require './app/controllers/tags_controller'
    def controller.params; end
    allow(controller).to receive(:params){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before do
      def controller.run clazz, hash; end
      expect(controller).to receive(:run).with(TagRunners::Show, :id){ :tag }
    end
    it{ subject }
  end

end
