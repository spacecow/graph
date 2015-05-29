class NotesController < ApplicationController

  def new
    @note = Note.new
    @books = run(BookRunners::Index, current_universe_id)
  end

end
