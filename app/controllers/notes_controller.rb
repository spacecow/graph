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
        if note.article_id
          redirect_to article_path(note.article_id)
        elsif note.event_id 
          redirect_to event_path(note.event_id)
        end
      end
      on.failure do |note|
        @note = note
        run(ArticleRunners::Show, note.article_id, universe_id:current_universe_id) do |on|
          on.success do |article, _, notes, relation, events, relation_types, relations, article_tags, tagging, tags, citation, citation_targets|
            @article          = article
            @notes            = notes
            @relation         = relation
            @events           = events
            @relation_types   = relation_types
            @relations        = relations
            @article_tags     = article_tags
            @tagging          = tagging
            @tags             = tags
            @citation         = citation
            @citation_targets = citation_targets
          end
        end
        render 'articles/show' 
      end
    end
  end

  def edit
    session[:redirect_to] = request.referer || root_path
    run(NoteRunners::Edit, params[:id]) do |on|
      on.success do |note|
        @note = note
      end
    end
  end

  def update
    run(NoteRunners::Update, params[:id], note_params) do |on|
      on.success do |note|
        redirect_to session.delete(:redirect_to)
      end
    end
  end

  def destroy
    tag_id = params[:tag_id]
    run(NoteRunners::Destroy, params[:id]) do |on|
      on.success do |note|
        if tag_id
          redirect_to tag_path(tag_id)
        elsif note.article_id
          redirect_to article_path(note.article_id)
        elsif note.event_id 
          redirect_to event_path(note.event_id)
        end
      end
    end
  end

  private

    def note_params
      params.require(:note).permit(:article_id, :event_id, :text)
    end

end
