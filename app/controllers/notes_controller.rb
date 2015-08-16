class NotesController < ApplicationController

  def show
    @mention = Mention.new
  end

  def new
    @note = Note.new
    @books = run(BookRunners::Index, current_universe_id).
      map{|e| [e["title"],e["id"]]}
  end

  def create
    run(NoteRunners::Create, note_params) do |on|
      on.success do |note|
        redirect_to article_path note.article_id
      end
      on.failure do |note|
        @article = run(ArticleRunners::Show, note.article_id)
        @notes = @article.notes
        @note = note 
        render 'articles/show' 
      end
    end
  end

  private

    def note_params
      params.require(:note).permit(:article_id, :text)
    end


end
