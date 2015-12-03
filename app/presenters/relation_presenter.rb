class RelationPresenter < BasePresenter
  presents :relation

  def title; relation.type.underscore.capitalize.gsub(/_/,' ') end

  def type; h.link_to title, h.relation_path(relation.id) end

  def references_comments
    relation.references.map(&:comment).join(', ')
  end

end

