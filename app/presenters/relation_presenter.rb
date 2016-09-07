class RelationPresenter < BasePresenter
  presents :relation

  def title; relation.type.underscore.capitalize.gsub(/_/,' ') end

  def type; h.link_to title, h.relation_path(relation.id) end

  def references_comments
    relation.references.map(&:comment).join(', ')
  end

  def origin; h.link_to relation.origin_name, h.article_path(relation.origin_id) end 
  def origin_gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[relation.origin_gender]
  end

  def target; h.link_to relation.target_name, h.article_path(relation.target_id) end
  def target_gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[relation.target_gender]
  end

  def invert_link
    h.link_to "Invert", h.invert_relation_path(relation.id), method: :put
  end

end
