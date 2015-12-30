require 'action_controller'

describe "ArticleMentionsController" do

  let(:controller){ ArticleMentionsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/article_mentions_controller'
    def controller.session; raise NotImplementedError end
    def controller.request; raise NotImplementedError end
    def controller.redirect_to path; raise NotImplementedError end
  end

  subject{ controller.send function }

  describe "REST" do

    let(:runner){ double :runner }

    before do
      def controller.run runner, *opts; raise NotImplementedError end
    end

    describe "#create" do
      let(:function){ :create }
      let(:session){ {} }
      let(:request){ double :request }
      before do
        stub_const "ArticleMentionRunners::Create", Class.new
        expect(controller).to receive(:session).with(no_args).at_least(1){ session }
        expect(controller).to receive(:request).with(no_args){ request }
        expect(controller).to receive(:mention_params).with(no_args){ :params }
        expect(controller).to receive(:run).
          with(ArticleMentionRunners::Create,:params).and_yield(runner)
        expect(request).to receive(:referer).with(no_args){ :path }
        expect(runner).to receive(:success).with(no_args).and_yield
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      end
      it{ subject }
    end

    describe "#edit" do
      let(:function){ :edit }
      let(:session){ {} }
      let(:params){{ id: :id }}
      let(:request){ double :request }
      before do
        stub_const "ArticleMentionRunners::Edit", Class.new
        def controller.params; raise NotImplementedError end
        def controller.current_universe_id; raise NotImplementedError end
        expect(controller).to receive(:session).with(no_args){ session }
        expect(controller).to receive(:request).with(no_args){ request }
        expect(controller).to receive(:params).with(no_args){ params }
        expect(controller).to receive(:current_universe_id).
          with(no_args){ :universe_id }
        expect(controller).to receive(:run).
          with(ArticleMentionRunners::Edit, :id, universe_id: :universe_id).
          and_yield(runner)
        expect(runner).to receive(:success).with(no_args).
          and_yield(:mention,:articles)
        expect(request).to receive(:referer).with(no_args){ :path }
      end
      it{ subject }
    end

    describe "#update" do
      let(:function){ :update }
      let(:session){{ redirect_to: :path }}
      let(:params){{ id: :id }}
      before do
        stub_const "ArticleMentionRunners::Update", Class.new
        def controller.params; raise NotImplementedError end
        expect(controller).to receive(:params).with(no_args){ params }
        expect(controller).to receive(:mention_params).with(no_args){ :params }
        expect(controller).to receive(:run).
          with(ArticleMentionRunners::Update, :id, :params).and_yield(runner)
        expect(runner).to receive(:success).with(no_args).and_yield
        expect(controller).to receive(:session).with(no_args){ session }
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      end
      it{ subject }
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
        let(:params_hash){{ article_mention:{ origin_id: :origin_id,
          target_id: :target_id, content: :content, xxx: :xxx }}} 
        it{ should eq({ "origin_id" => :origin_id, "target_id" => :target_id,
          "content" => :content }) }
      end
    end
  end

end
