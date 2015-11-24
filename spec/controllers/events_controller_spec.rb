describe "EventsController" do

  let(:controller){ EventsController.new }

  before do
    class ApplicationController
      def run clazz, *opts; raise NotImplementedError end
      def params; raise NotImplementedError end
    end unless defined?(Rails)
    require './app/controllers/events_controller'

    allow(controller).to receive(:params){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    before do
      stub_const "EventRunners::Show", Class.new
      def controller.current_universe_id; end
      expect(controller).to receive(:run).
        with(EventRunners::Show, :id, universe_id: :universe_id).and_yield(runner)
      expect(runner).to receive(:success).
        with(no_args).and_yield(:event,:articles,:participation)
      expect(controller).to receive(:current_universe_id).
        with(no_args).at_least(1){ :universe_id }
    end
    it{ subject }
  end

  describe "#new" do
    let(:function){ :new }
    let(:runner){ double :runner }
    before do
      stub_const "EventRunners::New", Class.new
      expect(controller).to receive(:run).
        with(EventRunners::New).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(:event,:events)
    end
    it{ subject }
  end

  describe "#create" do
    let(:function){ :create }

    before do
      def controller.current_universe_id; raise NotImplementedError end
      def controller.redirect_to id; raise NotImplementedError end
      expect(controller).to receive(:current_universe_id).with(no_args){ universe_id }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end

    context "Universe is not set" do
      let(:universe_id){ nil }
      before do
        def controller.universes_path; raise NotImplementedError end
        expect(controller).to receive(:universes_path).with(no_args){ :path }
      end
      it{ should be :redirect }
    end

    context "Universe is set" do
      let(:universe_id){ :universe_id }
      let(:runner){ double :runner }
      let(:event){ double :event }
      before do
        stub_const "EventRunners::Create", Class.new
        def controller.event_path id; raise NotImplementedError end
        expect(controller).to receive(:event_params).with(no_args){ :params }
        expect(controller).to receive(:run).with(EventRunners::Create, :params).and_yield(runner)
        expect(controller).to receive(:event_path).with(:id){ :path }
        expect(runner).to receive(:success).with(no_args).and_yield(event)
        expect(event).to receive(:id).with(no_args){ :id }
      end
      it{ should eq :redirect }
    end
  end

end
