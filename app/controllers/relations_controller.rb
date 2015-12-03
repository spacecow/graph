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

  private

    def relation_params
      params.require(:relation).permit(:origin_id, :target_id, :type)
    end

end
