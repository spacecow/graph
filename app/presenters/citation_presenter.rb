class CitationPresenter < BasePresenter

  presents :citation

  def content; citation.content end
  
  def origin_name
    return if citation.origin.nil?
    (" - " + h.link_to(citation.origin_name, h.article_path(citation.origin_id))).
      html_safe
  end
  def origin_gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[citation.origin_gender]
  end

  def target_gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[citation.target_gender]
  end
  def target_name
    return if citation.target.nil?
    h.link_to(citation.target_name, h.article_path(citation.target_id)) + ": "
  end

end
