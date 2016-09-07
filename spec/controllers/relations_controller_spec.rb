describe "RelationsController" do

  let(:controller){ RelationsController.new }

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
    let(:relation){ double :relation, origin_id: :origin_id }
    before do
      stub_const "RelationRunners::Create", Class.new
      def controller.run runner, params; raise NotImplementedError end
      def controller.article_path id; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      expect(controller).to receive(:relation_params).with(no_args){ :params } 
      expect(controller).to receive(:run).
        with(RelationRunners::Create,:params).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(relation)
      expect(controller).to receive(:article_path).with(:origin_id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end
    it{ should be :redirect }
  end

  describe "#invert" do
    let(:function){ :invert }
    let(:params){{ id: :id }}
    let(:mdl){ double :mdl }
    before do
      stub_const "RelationRunners::Invert", Class.new
      def controller.params; raise NotImplementedError end
      def controller.run runner, id; raise NotImplementedError end
      def controller.relation_path id; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      expect(controller).to receive(:params).with(no_args){ params }
      expect(controller).to receive(:run).with(RelationRunners::Invert,:id){ mdl }
      expect(controller).to receive(:relation_path).with(:id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(mdl).to receive(:id).with(no_args){ :id }
    end
    it{ should be :redirect } 
  end

end
