class RelationPresenter < BasePresenter
  presents :relation

  def type; h.link_to relation.type, h.relation_path(relation.id) end

  def references_comments
    relation.references.map(&:comment).join(', ')
  end

end

