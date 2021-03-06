describe "NotesController" do

  let(:controller){ NotesController.new }
  let(:note){ double :note }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/notes_controller'
    def controller.run runner, *params; raise NotImplementedError end
    def controller.params; raise NotImplementedError end
    def controller.article_path id; raise NotImplementedError end
    def controller.event_path id; raise NotImplementedError end
    def controller.tag_path id; raise NotImplementedError end
    def controller.redirect_to path; raise NotImplementedError end
    def controller.session; raise NotImplementedError end
    def controller.request; raise NotImplementedError end
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    before do
      stub_const "NoteRunners::Show", Class.new
      def controller.current_universe_id; raise NotImplementedError end
      expect(controller).to receive(:current_universe_id).with(no_args).at_least(1){ :universe_id }
      expect(controller).to receive(:run).
        with(NoteRunners::Show, :id, :universe_id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).
        and_yield(:note, :references, :note_tags, :reference, :tagging, :tags)
    end
    it{ subject }
  end

  describe "#new" do
    let(:function){ :new }
    #TODO does not work it{ subject }
  end

  describe "#create" do
    let(:function){ :create }
    let(:note_runner){ double :note_runner }
    let(:article_runner){ double :article_runner }
    before do
      stub_const "NoteRunners::Create", Class.new
      stub_const "ArticleRunners::Show", Class.new
      def controller.render path; raise NotImplementedError end
      def controller.current_universe_id; raise NotImplementedError end
      expect(note).to receive(:article_id).with(no_args).at_least(1){ :article_id }
      expect(controller).to receive(:run).
        with(NoteRunners::Create,:params).and_yield(note_runner)
      expect(controller).to receive(:run).
        with(ArticleRunners::Show,:article_id,universe_id: :universe_id).
        and_yield(article_runner)
      expect(controller).to receive(:note_params).with(no_args){ :params }
      expect(controller).to receive(:article_path).with(:article_id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:render).with("articles/show"){ :render }
      expect(controller).to receive(:current_universe_id).
        with(no_args){ :universe_id }
      expect(note_runner).to receive(:success).with(no_args).and_yield(note)
      expect(note_runner).to receive(:failure).with(no_args).and_yield(note)
      expect(article_runner).to receive(:success).with(no_args).
        and_yield(:article,:_,:notes,:relation,:events,
          :relation_types, :relations, :article_tags, :tagging, :tags, :citation,
          :citation_targets)
    end
    it{ subject }
  end

  describe "#edit" do
    let(:function){ :edit }
    let(:runner){ double :runner }
    let(:params){{ id: :id }}
    let(:session){ {} }
    let(:request){ double :request }
    before do
      stub_const "NoteRunners::Edit", Class.new
      expect(controller).to receive(:session).with(no_args){ session }
      expect(controller).to receive(:request).with(no_args){ request }
      expect(controller).to receive(:run).
        with(NoteRunners::Edit,:id).and_yield(runner)
      expect(request).to receive(:referer).with(no_args){ :path }
      expect(runner).to receive(:success).with(no_args).and_yield(note)
    end
    it{ subject; expect(session).to eq({redirect_to: :path}) }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    let(:runner){ double :runner }
    let(:session){{ redirect_to: :path }}
    before do
      stub_const "NoteRunners::Update", Class.new
      expect(controller).to receive(:note_params).with(no_args){ :params }
      expect(controller).to receive(:run).
        with(NoteRunners::Update,:id,:params).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(note)
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:session).with(no_args){ session }
    end
    it{ should be :redirect }
  end

  describe "#destroy" do
    let(:function){ :destroy }
    let(:runner){ double :runner }
    before do
      stub_const "NoteRunners::Destroy", Class.new
      expect(controller).to receive(:run).with(NoteRunners::Destroy,:id).
        and_yield(runner)
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(runner).to receive(:success).with(no_args).and_yield(note)
    end
    context "Return to tag" do
      let(:params){{ id: :id, tag_id: :tag_id }}
      before{ expect(controller).to receive(:tag_path).with(:tag_id){ :path }}
      it{ should be :redirect }
    end
    context "Return to article" do
      let(:params){{ id: :id }}
      before do
         expect(controller).to receive(:article_path).with(:article_id){ :path }
         allow(note).to receive(:article_id).with(no_args){ :article_id }
         allow(note).to receive(:event_id).with(no_args){ nil }
      end
      it{ should be :redirect }
    end
    context "Return to event" do
      let(:params){{ id: :id }}
      before do
         expect(controller).to receive(:event_path).with(:event_id){ :path }
         allow(note).to receive(:article_id).with(no_args){ nil }
         allow(note).to receive(:event_id).with(no_args){ :event_id }
      end
      it{ should be :redirect }
    end
  end

end
