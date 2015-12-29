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
      expect(runner).to receive(:success).with(no_args).
        and_yield(:event,:events,:articles,:participation,:participations,
          :parent_step,:notes,:note,:mention,:article_mention)
      expect(controller).to receive(:current_universe_id).
        with(no_args).at_least(1){ :universe_id }
    end
    it{ subject }
  end

  describe "#index" do
    let(:function){ :index }
    before do
      stub_const "EventRunners::Index", Class.new
      def controller.current_universe_id; end
      expect(controller).to receive(:run).
        with(EventRunners::Index, universe_id: :universe_id){ :events }
      expect(controller).to receive(:current_universe_id).
        with(no_args){ :universe_id }
    end
    it{ subject }
  end

  describe "#new" do
    let(:function){ :new }
    let(:runner){ double :runner }
    before do
      stub_const "EventRunners::New", Class.new
      def controller.current_universe_id; end
      expect(controller).to receive(:current_universe_id).
        with(no_args).at_least(1){ :universe_id }
      expect(controller).to receive(:run).
        with(EventRunners::New, universe_id: :universe_id).and_yield(runner)
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

  describe "#edit" do
    let(:function){ :edit }
    let(:params){{ id: :id }}
    let(:builder){ double :builder }
    let(:event){ double :event }
    before do
      stub_const "EventRunners::Edit", Class.new
      def controller.current_universe_id; raise NotImplementedError end
      expect(controller).to receive(:current_universe_id).
        with(no_args){ :universe_id }
      expect(controller).to receive(:run).with(EventRunners::Edit,:id).
        and_yield(builder)
      expect(builder).to receive(:success).with(no_args).and_yield(event)
    end
    it{ subject }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    let(:builder){ double :builder }
    let(:event){ double :event }
    before do
      stub_const "EventRunners::Update", Class.new
      def controller.current_universe_id; raise NotImplementedError end
      def controller.event_path id; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      expect(controller).to receive(:current_universe_id).
        with(no_args){ :universe_id }
      expect(controller).to receive(:event_params).with(no_args){ :params }
      expect(controller).to receive(:run).with(EventRunners::Update,:id,:params).
        and_yield(builder)
      expect(builder).to receive(:success).with(no_args).and_yield(event)
      expect(event).to receive(:id).with(no_args){ :id }
      expect(controller).to receive(:event_path).with(:id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end
    it{ subject }
  end

  describe "#destroy" do
    let(:function){ :destroy }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    before do
      stub_const "EventRunners::Destroy", Class.new
      def controller.events_path; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      expect(controller).to receive(:run).
        with(EventRunners::Destroy,:id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield
      expect(controller).to receive(:events_path).with(no_args){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end
    it{ should be :redirect }
  end

end
