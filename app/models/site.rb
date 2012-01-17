class Site
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # -= Extensions =-
  extend Extensions::Site::SubdomainDomains
  
  # -= Fields =-
  field :name
  field :robots_txt
  
  # -= Associations =-
  
  # -= Validations =-
  validates_presence_of :name
  # -= Callbacks =-
  
  # -= Behaviours =-
  enable_subdomain_n_domains_if_multi_sites
  
  # -= Methods =-
  
end