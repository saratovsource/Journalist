class Site
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # -= Extensions =-
  extend Extensions::Site::SubdomainDomains
  extend Extensions::Site::FirstInstallation
  
  # -= Fields =-
  field :name
  field :robots_txt
  
  # -= Associations =-
  embeds_many :memberships
  
  # -= Validations =-
  validates_presence_of :name
  
  # -= Callbacks =-
  
  # -= Behaviours =-
  enable_subdomain_n_domains_if_multi_sites
  accepts_nested_attributes_for :memberships
  
  # -= Methods =-
  
  def accounts
    Account.criteria.in(:_id => self.memberships.collect(&:account_id))
  end
  
  def admin_memberships
    self.memberships.find_all { |m| m.admin? }
  end
  
end