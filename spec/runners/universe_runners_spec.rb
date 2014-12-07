unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/universe_runners'

module UniverseRunners
  describe UniverseRunners do
    let(:repo){ double :repo }
    let(:context){ double :context, repo:repo }

    describe Index do
      before{ expect(repo).to receive(:all_universes){ [:univ1,:univ2] }}
      subject{ Index.new(context).run }
      it{ is_expected.to eq [:univ1,:univ2] }
    end
  end
end
