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
        expect(repo).to receive(:relation_types).with(no_args){ :relation_types }
        expect(repo).to receive(:article).with(:id){ article }
        expect(repo).to receive(:new_note).with(article_id: :article_id){ :note }
        expect(repo).to receive(:new_relation).
          with(origin_id: :article_id){ :relation }
        expect(repo).to receive(:articles).
          with(universe_id: :universe_id){ [target] }
        expect(article).to receive(:target_ids).with(no_args){ [:target_id] }
        expect(article).to receive(:notes).with(no_args){ :notes }
        expect(article).to receive(:events).with(no_args){ :events }
        expect(article).to receive(:relations).with(no_args){ :relations }
      end
      subject{ Show.new(context).run :id, universe_id: :universe_id }
      it{ subject }
    end

  end
end
