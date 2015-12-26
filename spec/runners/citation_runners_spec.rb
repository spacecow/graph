unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/citation_runners'

module CitationRunners

  describe CitationRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }

    describe Create do
      subject{ Create.new(context).run :params }
      before{ expect(repo).to receive(:save_citation).with(:params){ :citation }}
      it{ subject }
    end
  end

end
