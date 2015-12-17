require 'action_controller'

describe "MentionsController" do

  let(:controller){ MentionsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/mentions_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    before do
      def controller.run runner, *opts; raise NotImplementedError end
    end

    describe "#create" do
      let(:function){ :create }
      let(:runner){ double :runner }
      let(:mention){ double :mention }
      before do
        stub_const "MentionRunners::Create", Class.new
        def controller.event_path id; raise NotImplementedError end
        def controller.redirect_to path; raise NotImplementedError end
        expect(controller).to receive(:mention_params).with(no_args){ :params }
        expect(controller).to receive(:redirect_to).with(:path){ :redirect } 
        expect(controller).to receive(:run).
          with(MentionRunners::Create,:params).and_yield(runner)
        expect(runner).to receive(:success).with(no_args).and_yield(mention)
        expect(mention).to receive(:origin_id).with(no_args){ :origin_id }
        expect(controller).to receive(:event_path).with(:origin_id){ :path } 
      end
      it{ should be :redirect }
    end

  end

  describe "Private" do
    before do
      def controller.params; raise NotImplementedError end
      expect(controller).to receive(:params).with(no_args){ params }
    end
    describe "#mention_params" do
      let(:function){ :mention_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ mention:{
          origin_id: :origin_id, target_id: :target_id, xxx: :xxx }}} 
        it{ should eq({ "origin_id" => :origin_id, "target_id" => :target_id }) }
      end
    end
  end


end
