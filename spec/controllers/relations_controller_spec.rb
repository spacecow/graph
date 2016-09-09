describe "RelationsController" do

  let(:controller){ RelationsController.new }
  let(:mdl){ double :mdl }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/relations_controller'
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
  end

  describe "#create" do
    let(:function){ :create }
    let(:runner){ double :runner }
    before do
      stub_const "RelationRunners::Create", Class.new
      def controller.run runner, params; raise NotImplementedError end
      def controller.article_path id; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      expect(controller).to receive(:relation_params).with(no_args){ :params } 
      expect(controller).to receive(:run).
        with(RelationRunners::Create,:params).and_yield(runner)
      expect(controller).to receive(:article_path).with(:origin_id){ :path }
      expect(runner).to receive(:success).with(no_args).and_yield(mdl)
      expect(mdl).to receive(:origin_id).with(no_args){ :origin_id }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end
    it{ should be :redirect }
  end

  describe "#edit" do
    let(:function){ :edit }
    let(:request){ double :request }
    let(:session){{ redirect_to: :path }}
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    before do
      stub_const "RelationRunners::Edit", Class.new
      def controller.session; raise NotImplementedError end
      def controller.request; raise NotImplementedError end
      def controller.params; raise NotImplementedError end
      def controller.run runner, id; raise NotImplementedError end
      expect(controller).to receive(:session).with(no_args){ session }
      expect(controller).to receive(:request).with(no_args){ request }
      expect(request).to receive(:referer).with(no_args)
      expect(controller).to receive(:params).with(no_args){ params }
      expect(controller).to receive(:run).
        with(RelationRunners::Edit,:id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(:mdl, :types)
    end
    it{ should eq :types } 
  end

  describe "#update" do
    let(:function){ :update }
    let(:request){ double :request }
    let(:params){{ id: :id }}
    before do
      stub_const "RelationRunners::Update", Class.new
      def controller.params; raise NotImplementedError end
      def controller.run runner, id, params; raise NotImplementedError end
      def controller.session; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      expect(controller).to receive(:params).with(no_args){ params }
      expect(controller).to receive(:relation_params).with(no_args){ :params } 
      expect(controller).to receive(:run).
        with(RelationRunners::Update, :id, :params){ mdl }
      expect(controller).to receive(:session).with(no_args){ session }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end
    context "Session contains a redirect" do
      let(:session){{ redirect_to: :path }}
      it{ should eq :redirect } 
    end
    context "Session contains no redirect" do
      let(:session){ {} }
      before do
        def controller.relation_path path; raise NotImplementedError end
        expect(controller).to receive(:relation_path).with(:id){ :path }
        expect(mdl).to receive(:id).with(no_args){ :id }
      end
      it{ should eq :redirect } 
    end
  end

  describe "#invert" do
    let(:function){ :invert }
    let(:request){ double :request }
    let(:params){{ id: :id }}
    before do
      stub_const "RelationRunners::Invert", Class.new
      def controller.request; raise NotImplementedError end
      def controller.params; raise NotImplementedError end
      def controller.run runner, id; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      expect(controller).to receive(:request).with(no_args){ request }
      expect(controller).to receive(:params).with(no_args){ params }
      expect(controller).to receive(:run).with(RelationRunners::Invert,:id){ mdl }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(request).to receive(:referer).with(no_args){ :path }
    end
    it{ should be :redirect } 
  end

end
