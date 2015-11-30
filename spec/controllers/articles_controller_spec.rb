describe "ArticlesController" do

  let(:controller){ ArticlesController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require 'action_controller'
    require './app/controllers/articles_controller'
    def controller.current_universe_id; raise NotImplementedError end
    expect(controller).to receive(:current_universe_id).at_least(1){ :universe_id }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    before do
      stub_const "ArticleRunners::Show", Class.new
      def controller.params; raise NotImplementedError end
      def controller.run runner, id, params; raise NotImplementedError end
      expect(controller).to receive(:params).with(no_args){ params }
      expect(controller).to receive(:run).
        with(ArticleRunners::Show,:id,universe_id: :universe_id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).
        and_yield(:article,:note,:notes,:relation,:targets, :events, :relation_types)
    end
    it{ subject }
  end

  describe "#new" do
    let(:function){ :new }
    let(:runner){ double :runner }
    before do
      stub_const "ArticleRunners::New", Class.new
      def controller.run runner; raise NotImplementedError end
      expect(controller).to receive(:run).
        with(ArticleRunners::New).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).
        and_yield(:article, :article_types)
    end 
    it{ subject }
  end

  describe "#create" do
    let(:function){ :create }
    let(:runner){ double :runner }
    before do
      stub_const "ArticleRunners::Create", Class.new
      def controller.run runner, params; raise NotImplementedError end
      def controller.universe_path id; raise NotImplementedError end
      def controller.redirect_to path; raise NotImplementedError end
      def controller.render page; raise NotImplementedError end
      expect(controller).to receive(:article_params).with(no_args){ :params }
      expect(controller).to receive(:run).
        with(ArticleRunners::Create,:params).and_yield(runner)
      expect(controller).to receive(:universe_path).with(:universe_id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:render).with(:new){ :render }
      expect(runner).to receive(:success).with(no_args).and_yield
      expect(runner).to receive(:failure).
        with(no_args).and_yield(:article, :article_types)
    end 
    it{ subject }
  end

  describe "#article_params" do
    let(:function){ :article_params }
    let(:params){
      ActionController::Parameters.new(article:{name: :name, type: :type, id: :id}) }
    before do
      def controller.params; raise NotImplementedError end
      expect(controller).to receive(:params).with(no_args){ params } 
    end
    it{ should eq({"name" => :name, "type" => :type, "universe_id" => :universe_id}) }
  end

end
