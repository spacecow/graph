class TagsController < ApplicationController

  def show
    @tag = run(TagRunners::Show, params[:id])
    @notes = @tag.notes
  end

  def index
    return redirect_to universes_path if current_universe_id.nil?
    @tags = run(TagRunners::Index, current_universe_id)
    respond_to do |f|
      f.html
      f.json{
        render json:@tags.
          map{|e| {id:e.id, title:e.title}}.
          select{|e| e[:title].downcase.include?(params[:q].downcase)}}
    end
  end

  def new
    return redirect_to universes_path if current_universe_id.nil?
    @tag = run(TagRunners::New)
  end

  def create
    return redirect_to universes_path if current_universe_id.nil?
    run(TagRunners::Create, tag_params) do |on|
      on.success do
        redirect_to tags_path
      end
      on.failure do |tag| 
        @tag = tag
        render :new
      end
    end
  end

  def destroy
    session[:redirect_to] = request.referer || root_path
    run(TagRunners::Destroy, params[:id], delete_tag_params) 
    redirect_to session.delete(:redirect_to)
  end

  private

    def delete_tag_params
      params.require(:tag).permit(:tagable_type, :tagable_id)
    end

    def tag_params
      params.require(:tag).permit(:tagable_id, :tagable_type, :title).
        merge({universe_id:current_universe_id})
    end

end
