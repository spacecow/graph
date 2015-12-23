class CitationPresenter < BasePresenter

  presents :citation

  def content; citation.content end

end
