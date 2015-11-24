describe "EventsController" do

  let(:controller){ EventsController.new }

  before do
    class ApplicationController
      def run clazz, hash={}; raise NotImplementedError end
      def params; raise NotImplementedError end
    end unless defined?(Rails)
    require './app/controllers/events_controller'

    allow(controller).to receive(:params){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    let(:event){ double :event, id: :event_id }
    let(:event_article){ double :event_article, id: :article_id }
    let(:article){ double :article, id: :article_id }
    before do
      stub_const "EventRunners::Show", Class.new
      stub_const "ArticleRunners::Index", Class.new
      stub_const "ParticipationRunners::New", Class.new
      def controller.current_universe_id; end
      expect(controller).to receive(:run).with(EventRunners::Show,:id){ event }
      expect(controller).to receive(:run).
        with(ArticleRunners::Index, universe_id: :universe_id){ [article] }
      expect(controller).to receive(:run).
        with(ParticipationRunners::New, event_id: :event_id){ :participation }
      expect(controller).to receive(:current_universe_id).
        with(no_args).at_least(1){ :universe_id }
      expect(event).to receive(:articles).with(no_args){ [event_article] }
    end
    it{ subject }
  end

  describe "#new" do
    let(:function){ :new }
    before do
      stub_const "EventRunners::New", Class.new
      stub_const "EventRunners::Index", Class.new
      expect(controller).to receive(:run).with(EventRunners::New){ :event }
      expect(controller).to receive(:run).with(EventRunners::Index){ :events }
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
