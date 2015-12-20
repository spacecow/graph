unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/tag_runners'

module TagRunners

  describe TagRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }

    describe Destroy do
      subject{ Destroy.new(context).run :id, :params }
      before{ expect(repo).to receive(:delete_tag).with(:id,:params){ :tag } }
      it{ should be :tag }
    end

  end
end

