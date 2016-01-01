require 'action_controller'

describe "ParticipationsController" do

  let(:controller){ ParticipationsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/participations_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    let(:runner){ double :runner }
    let(:participation){ double :participation }

    before do
      def controller.run runner, *opts; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
    end

    describe "#create" do
      let(:function){ :create }
      before do
        stub_const "ParticipationRunners::Create", Class.new
        def controller.event_path id; raise NotImplementedError end
        expect(controller).to receive(:participation_params).
          with(no_args){ :params }
        expect(controller).to receive(:run).
          with(ParticipationRunners::Create, :params).and_yield(runner)
        expect(runner).to receive(:success).with(no_args).and_yield(participation)
        expect(controller).to receive(:event_path).with(:event_id){ :path }
        expect(participation).to receive(:event_id).with(no_args){ :event_id }
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      end
      it{ should be :redirect }
    end

    describe "#edit" do
      let(:function){ :edit }
      let(:session){{}}
      let(:params){{ id: :id }}
      let(:request){ double :request }
      before do
        stub_const "ParticipationRunners::Edit", Class.new
        def controller.session; raise NotImplementedError end 
        def controller.request; raise NotImplementedError end 
        def controller.params; raise NotImplementedError end 
        def controller.current_universe_id; raise NotImplementedError end 
        expect(controller).to receive(:session).with(no_args){ session }
        expect(controller).to receive(:params).with(no_args){ params }
        expect(controller).to receive(:request).with(no_args){ request }
        expect(controller).to receive(:current_universe_id).
          with(no_args){ :universe_id }
        expect(request).to receive(:referer).with(no_args){ :path }
        expect(controller).to receive(:run).
          with(ParticipationRunners::Edit, :id, universe_id: :universe_id).
          and_yield(runner)
        expect(runner).to receive(:success).with(no_args).
          and_yield(:participation,:articles)
      end
      it{ subject }
    end

    describe "#update" do
      let(:function){ :update }
      let(:params){{ id: :id }}
      let(:session){{ redirect_to: :path }}
      before do
        stub_const "ParticipationRunners::Update", Class.new
        def controller.params; raise NotImplementedError end 
        def controller.session; raise NotImplementedError end 
        expect(controller).to receive(:params).with(no_args){ params }
        expect(controller).to receive(:session).with(no_args){ session }
        expect(controller).to receive(:participation_params).
          with(no_args){ :params }
        expect(controller).to receive(:run).
          with(ParticipationRunners::Update, :id, :params).and_yield(runner)
        expect(runner).to receive(:success).with(no_args).and_yield
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      end
      it{ should be :redirect }
      it{ subject; expect(session).to eq({}) }
    end

    describe "#destroy" do
      let(:function){ :destroy }
      let(:session){ {} }
      let(:request){ double :request }
      let(:params){{ id: :id }}
      let(:runner){ double :runner }
      before do
        stub_const "ParticipationRunners::Destroy", Class.new
        def controller.session; raise NotImplementedError end 
        def controller.request; raise NotImplementedError end 
        def controller.params; raise NotImplementedError end 
        allow(controller).to receive(:session).with(no_args){ session }
        expect(controller).to receive(:request).with(no_args){ request }
        expect(controller).to receive(:params).with(no_args){ params }
        expect(controller).to receive(:run).
          with(ParticipationRunners::Destroy, :id).and_yield(runner)
        expect(request).to receive(:referer).with(no_args){ :path }
        expect(runner).to receive(:success).with(no_args).and_yield
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      end
      it{ should be :redirect }
      it{ subject; expect(session).to eq({}) }
    end
  end

  describe "Private" do
    before do
      def controller.params; raise NotImplementedError end
      expect(controller).to receive(:params).with(no_args){ params }
    end
    describe "#participation_params" do
      let(:function){ :participation_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ participation:{
          participant_id: :participant_id, event_id: :event_id, xxx: :xxx }}} 
        it{ should eq({ "participant_id" => :participant_id, "event_id" => :event_id }) }
      end
    end
  end

end
