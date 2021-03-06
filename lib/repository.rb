class Repository
  include Repo::ArticleMethods
  include Repo::ArticleMentionMethods
  include Repo::ArticleTypeMethods
  include Repo::BookMethods
  include Repo::CitationMethods
  include Repo::EventMethods
  include Repo::ReferenceMethods
  include Repo::MentionMethods
  include Repo::NoteMethods
  include Repo::ParticipationMethods
  include Repo::RelationMethods
  include Repo::RelationTypeMethods
  include Repo::StepMethods
  include Repo::TagMethods
  include Repo::TaggingMethods
  include Repo::UniverseMethods
end
