describe "EventsController" do

  let(:controller){ EventsController.new }

  before do
    stub_const "EventRunners::Show", Class.new
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/events_controller'
    def controller.run clazz, hash; end
    def controller.params; end
    allow(controller).to receive(:params){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before do
      expect(controller).to receive(:run).with(EventRunners::Show,:id)
    end
    it{ subject }
  end

end
