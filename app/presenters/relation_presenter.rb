class RelationPresenter < BasePresenter
  presents :relation

  def type; h.link_to relation.type, h.relation_path(relation.id) end

end

