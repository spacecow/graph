class Repository
  include Repo::ArticleMethods
  include Repo::ArticleTypeMethods
  include Repo::BookMethods
  include Repo::ReferenceMethods
  include Repo::NoteMethods
  include Repo::UniverseMethods
end
