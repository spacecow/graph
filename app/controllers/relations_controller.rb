class RelationsController < ApplicationController

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
