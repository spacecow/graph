class NotesController < ApplicationController

  def new
    @note = Note.new
    @books = run(BookRunners::Index, current_universe_id).
      map{|e| [e["title"],e["id"]]}
  end

  def create
    render json:{}
  end

end
