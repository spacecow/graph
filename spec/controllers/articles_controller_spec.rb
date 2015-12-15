describe "ArticlesController" do

  let(:controller){ ArticlesController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require 'action_controller'
    require './app/controllers/articles_controller'
    def controller.current_universe_id; raise NotImplementedError end
    def controller.params; raise NotImplementedError end
    def controller.run runner, *opts; raise NotImplementedError end
    def controller.redirect_to path; raise NotImplementedError end
    expect(controller).to receive(:current_universe_id).at_least(1){ :universe_id }
    allow(controller).to receive(:params).with(no_args){ params } 
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    before do
      stub_const "ArticleRunners::Show", Class.new
      expect(controller).to receive(:params).with(no_args){ params }
      expect(controller).to receive(:run).
        with(ArticleRunners::Show,:id,universe_id: :universe_id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).
        and_yield(:article,:note,:notes,:relation,:targets, :events,
          :relation_types, :relations, :article_tags, :tagging, :tags)
    end
    it{ subject }
  end

  describe "#new" do
    let(:function){ :new }
    let(:runner){ double :runner }
    before do
      stub_const "ArticleRunners::New", Class.new
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
      def controller.universe_path id; raise NotImplementedError end
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

  describe "#edit" do
    let(:function){ :edit }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    before do
      stub_const "ArticleRunners::Edit", Class.new
      expect(controller).to receive(:run).
        with(ArticleRunners::Edit,:id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).
        and_yield(:article, :article_types)
    end
    it{ subject }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    let(:article){ double :article }
    before do
      stub_const "ArticleRunners::Update", Class.new
      def controller.article_path id; raise NotImplementedError end
      expect(controller).to receive(:article_params).with(no_args){ :params }
      expect(controller).to receive(:run).
        with(ArticleRunners::Update,:id,:params).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(article)
      expect(article).to receive(:id).with(no_args){ :id }
      expect(controller).to receive(:article_path).with(:id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
    end
    it{ subject }
  end

  describe "#article_params" do
    let(:function){ :article_params }
    let(:params){
      ActionController::Parameters.new(article:{name: :name, type: :type, id: :id}) }
    it{ should eq({"name" => :name, "type" => :type, "universe_id" => :universe_id}) }
  end

end
