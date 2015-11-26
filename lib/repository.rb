class Repository
  include Repo::ArticleMethods
  include Repo::ArticleTypeMethods
  include Repo::BookMethods
  include Repo::EventMethods
  include Repo::ReferenceMethods
  include Repo::NoteMethods
  include Repo::ParticipationMethods
  include Repo::StepMethods
  include Repo::TagMethods
  include Repo::TaggingMethods
  include Repo::UniverseMethods
end
