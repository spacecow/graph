unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/mention_runners'

module MentionRunners

  describe MentionRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }

    describe Create do
      subject{ Create.new(context).run :params }
      before{ expect(repo).to receive(:save_mention).with(:params){ :mention }}
      it{ subject }
    end
  end

end
