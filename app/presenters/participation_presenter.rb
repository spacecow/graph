class ParticipationPresenter < BasePresenter

  presents :participation

  def content
    content = participation.content
    content = "Edit" if content.blank?
    (" - " + h.link_to(content, h.edit_participation_path(participation.id))).
      html_safe
  end

  def delete_link
    h.link_to "Delete", h.participation_path(participation.id),
      method: :delete, data:{confirm:"Are you sure?"}
  end

  def gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[participation.gender]
  end

  def name; h.link_to participation.name, h.article_path(participation.participant_id) end

end
