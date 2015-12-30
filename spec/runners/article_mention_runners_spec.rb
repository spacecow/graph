unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/article_mention_runners'

module ArticleMentionRunners

  describe ArticleMentionRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }

    describe Create do
      before do
        expect(repo).to receive(:save_article_mention).with(:params)
      end
      subject{ Create.new(context).run :params }
      it{ should eq [] }
    end

    describe Edit do
      before do
        expect(repo).to receive(:article_mention).with(:id){ :mention }
        expect(repo).to receive(:articles).with(universe_id: :universe_id).
          and_return(:articles)
      end
      subject{ Edit.new(context).run :id, universe_id: :universe_id }
      it{ should eq [:mention,:articles] }
    end

    describe Update do
      before do
        expect(repo).to receive(:update_article_mention).with(:id,:params)
      end
      subject{ Update.new(context).run :id, :params }
      it{ should eq [] }
    end
  end

end
