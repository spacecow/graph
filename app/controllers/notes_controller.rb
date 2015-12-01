class NotesController < ApplicationController

  def show
    run(NoteRunners::Show, params[:id]) do |on|
      on.success do |note, references, note_tags, reference, tagging, tags|
        @note = note
        @references = references
        @note_tags = note_tags 
        @reference = reference
        @tagging = tagging
        @tags = tags
      end
    end
  end

  def new
    run(NoteRunners::New) do |on|
      on.success do |note|
        @note = note
      end
    end
    @books = run(BookRunners::Index, universe_id:current_universe_id).
      map{|e| [e["title"],e["id"]]}
  end

  def create
    run(NoteRunners::Create, note_params) do |on|
      on.success do |note|
        redirect_to article_path note.article_id
      end
      on.failure do |note|
        @note = note
        run(ArticleRunners::Show, note.article_id, universe_id:current_universe_id) do |on|
          on.success do |article, _, notes, relation, targets, events, relation_types|
            @article        = article
            @notes          = notes
            @relation       = relation
            @targets        = targets
            @events         = events
            @relation_types = relation_types
          end
        end
        render 'articles/show' 
      end
    end
  end

  def edit
    run(NoteRunners::Edit, params[:id]) do |on|
      on.success do |note|
        @note = note
      end
    end
  end

  def update
    run(NoteRunners::Update, params[:id], note_params) do |on|
      on.success do |note|
        redirect_to article_path(note.article_id)
      end
    end
  end

  def destroy
    run(NoteRunners::Destroy, params[:id]) do |on|
      on.success do |note|
        redirect_to article_path(note.article_id)
      end
    end
  end

  private

    def note_params
      params.require(:note).permit(:article_id, :text)
    end

end
