require_dependency './app/runners/runner'

module NoteRunners

  class Show < Runner
    def run id
      note = repo.note id
      references = note.references
      note_tags = note.tags
      reference = repo.new_reference note_id:note.id 
      tagging = repo.new_tagging tagable_id:note.id, tagable_type:"Note"
      tags = repo.tags
      success note, references, note_tags, reference, tagging, tags
    end
  end

  class New < Runner
    def run params={}
      note = repo.new_note params
      success note
    end
  end

  class Create < Runner
    def run note_params
      note = repo.new_note note_params
      note = repo.save_note note
      if note.errors.empty?
        success note
      else
        failure note
      end
    end
  end

end
