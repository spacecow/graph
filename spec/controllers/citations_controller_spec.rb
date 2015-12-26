require 'action_controller'

describe "CitationsController" do

  let(:controller){ CitationsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/citations_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    before do
      def controller.run runner, *opts; raise NotImplementedError end
      def controller.session; raise NotImplementedError end
      def controller.request; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
    end

    describe "#create" do
      let(:function){ :create }
      let(:session){ {} }
      let(:request){ double :request }
      let(:runner){ double :runner }
      before do
        stub_const "CitationRunners::Create", Class.new
        expect(controller).to receive(:session).with(no_args).at_least(1){ session }
        expect(controller).to receive(:request).with(no_args){ request }
        expect(request).to receive(:referer).with(no_args){ :path }
        expect(controller).to receive(:citation_params).with(no_args){ :params }
        expect(controller).to receive(:redirect_to).with(:path){ :redirect } 
        expect(controller).to receive(:run).
          with(CitationRunners::Create,:params).and_yield(runner)
        expect(runner).to receive(:success).with(no_args).and_yield
      end
      it{ should be :redirect }
    end
  end

  describe "Private" do
    before do
      def controller.params; raise NotImplementedError end
      expect(controller).to receive(:params).with(no_args){ params }
    end
    describe "#citation_params" do
      let(:function){ :citation_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ citation:{ content: :content, xxx: :xxx }}} 
        it{ should eq({ "content" => :content }) }
      end
    end
  end

end
