class ParticipationPresenter < BasePresenter

  presents :participation

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
