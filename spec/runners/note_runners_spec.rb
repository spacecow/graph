unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/note_runners'

module NoteRunners

  describe NoteRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }

    describe Destroy do
      subject{ Destroy.new(context) }
      it{ subject }
    end

  end
end
