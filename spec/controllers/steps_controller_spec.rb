describe "StepsController" do

  let(:controller){ StepsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/steps_controller' 
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:runner){ double :runner }
    let(:step){ double :step }
    before do
      stub_const "StepRunners::Create", Class.new
      def controller.run runner, params; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      def controller.event_path id; raise NotImplementedError end
      expect(controller).to receive(:step_params).with(no_args){ :params }
      expect(controller).to receive(:run).
        with(StepRunners::Create, :params).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(step)
      expect(step).to receive(:child_id).with(no_args){ :child_id }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:event_path).with(:child_id){ :path }
    end
    it{ should eq :redirect }
  end

end
