describe "TagsController" do

  let(:controller){ TagsController.new }

  before do
    stub_const "TagRunners::Show", Class.new
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/tags_controller'
    def controller.params; end
    allow(controller).to receive(:params){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    let(:tag){ double :tag }
    before do
      def controller.run clazz, hash; end
      expect(controller).to receive(:run).with(TagRunners::Show, :id){ tag }
      expect(tag).to receive(:notes).with(no_args)
    end
    it{ subject }
  end

end
