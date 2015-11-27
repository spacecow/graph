describe "RelationsController" do

  let(:controller){ RelationsController.new }

  before do
    class ApplicationController; end
    require './app/controllers/relations_controller'
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:runner){ double :runner }
    let(:relation){ double :relation, origin_id: :origin_id }
    before do
      stub_const "RelationRunners::Create", Class.new
      def controller.run runner, params; end
      def controller.article_path id; end
      def controller.redirect_to path; end
      expect(controller).to receive(:relation_params).with(no_args){ :params } 
      expect(controller).to receive(:run).
        with(RelationRunners::Create,:params).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(relation)
      expect(controller).to receive(:article_path).with(:origin_id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end
    it{ should be :redirect }
  end

end
