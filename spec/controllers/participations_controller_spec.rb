describe "ParticipationsController" do

  let(:controller){ ParticipationsController.new }

  before do
    class ApplicationController
      def params; end
    end unless defined?(Rails)
    require './app/controllers/participations_controller'
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:participation){ double :participation }
    before do
      stub_const "ParticipationRunners::Create", Class.new
      def controller.run runner, params; end
      def controller.event_path id; end
      def controller.redirect_to path; end
      expect(controller).to receive(:participation_params).with(no_args){ :params }
      expect(controller).to receive(:run).
        with(ParticipationRunners::Create, :params){ participation }
      expect(controller).to receive(:event_path).with(:event_id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(participation).to receive(:event_id).with(no_args){ :event_id }
    end
    it{ should eq :redirect }
  end
end
