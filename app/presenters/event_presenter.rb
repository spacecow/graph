class EventPresenter < BasePresenter
  presents :event

  def parent
    event.parent.try(:title)
  end

end
