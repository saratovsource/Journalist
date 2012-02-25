class AbstractRouter
  include Journalist::Document
  include Extensions::Site::IncludedIn
  
  # -= Fields=-
  field :url
  
  # -= Validation =-
  validates_presence_of   :url
  validates_uniqueness_of :url, :scope => [:site]
end