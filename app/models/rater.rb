class Rater
  include Journalist::Document
  include Extensions::Site::IncludedIn

  field :ip_address

  validates :ip_address, :uniqueness => [:site]
end
