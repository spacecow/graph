class ParticipationPresenter < BasePresenter

  presents :participation

  def gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[participation.gender]
  end

  def name; participation.name end

end
