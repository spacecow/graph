class RelationsController < ApplicationController

  def show
    run(RelationRunners::Show, params[:id]) do |on|
      on.success do |relation, reference, references|
        @relation = relation
        @reference = reference
        @references = references
      end
    end
  end

  def create
    run(RelationRunners::Create, relation_params) do |on|
      on.success do |relation|
        redirect_to article_path(relation.origin_id)
      end
    end
  end

  def edit
    session[:redirect_to] = request.referer
    run(RelationRunners::Edit, params[:id]) do |on|
      on.success do |relation, relation_types|
        @relation = relation
        @relation_types = relation_types
      end
    end
  end

  def update
    relation = run(RelationRunners::Update, params[:id], relation_params)
    redirect_to session[:redirect_to] || relation_path(relation.id)
  end

  def invert
    redirect_to = request.referer || root_path
    relation = run(RelationRunners::Invert, params[:id])
    redirect_to redirect_to 
  end

  private

    def relation_params
      params.require(:relation).permit(:origin_id, :target_id, :type)
    end

end
