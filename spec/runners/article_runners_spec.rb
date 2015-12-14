unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/article_runners'

module ArticleRunners

  describe ArticleRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }

    describe Show do
      let(:article){ double :article, id: :article_id }
      let(:target){ double :target, id: :target_id }
      before do
        expect(repo).to receive(:relation_types).with(no_args){ ["Owner"] }
        expect(repo).to receive(:article).with(:id){ article }
        expect(repo).to receive(:new_note).with(article_id: :article_id){ :note }
        expect(repo).to receive(:new_relation).
          with(origin_id: :article_id){ :relation }
        expect(repo).to receive(:articles).
          with(universe_id: :universe_id){ [target] }
        expect(article).to receive(:target_ids).with(no_args){ [:target_id] }
        expect(article).to receive(:notes).with(no_args){ :notes }
        expect(article).to receive(:events).with(no_args){ :events }
        expect(article).to receive(:tags).with(no_args){ :tags }
        expect(article).to receive(:relations).with(no_args){ :relations }
      end
      subject{ Show.new(context).run :id, universe_id: :universe_id }
      it{ subject }
    end

    describe Edit do
      subject{ Edit.new(context).run :id }
      before do
        expect(repo).to receive(:article).with(:id){ :article }
        expect(repo).to receive(:article_types).with(no_args){ :article_types }
      end
      it{ subject }
    end

    describe Update do
      subject{ Update.new(context).run :id, :params }
      before do
        expect(repo).to receive(:article).with(:id){ :article }
        expect(repo).to receive(:update_article).with(:article,:params)
      end
      it{ subject }
    end

  end
end
