class NotesController < ApplicationController

  def show
    @note = run(NoteRunners::Show, params[:id])
    @references = @note.references
    @note_tags = @note.tags
    @reference = run(ReferenceRunners::New, note_id:@note.id)
    @tagging = run(TaggingRunners::New, tagable_id:@note.id, tagable_type:"Note")
    @tags = run(TagRunners::Index)
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
        #TODO make prettier 
        @article = repo.article note.article_id
        @notes = @article.notes
        @note = note 
        @relation = Relation.new
        @targets = repo.articles(universe_id:current_universe_id)
        render 'articles/show' 
      end
    end
  end

  private

    def note_params
      params.require(:note).permit(:article_id, :text)
    end


end
