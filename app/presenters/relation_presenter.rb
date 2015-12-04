class RelationPresenter < BasePresenter
  presents :relation

  def target; h.link_to relation.target_name, h.article_path(relation.target_id) end

  def title; relation.type.underscore.capitalize.gsub(/_/,' ') end

  def type; h.link_to title, h.relation_path(relation.id) end

  def references_comments
    relation.references.map(&:comment).join(', ')
  end

  def gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[relation.target_gender]
  end

end

