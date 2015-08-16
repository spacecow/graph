require_dependency './app/runners/runner'

module NoteRunners

  class New < Runner
    def run params
      repo.new_note params
    end
  end

  class Create < Runner
    def run note_params
      note = repo.new_note note_params
      note = repo.save_note note
      success note
    end
  end

end
