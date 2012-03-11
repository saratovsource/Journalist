class Site
  include Journalist::Document
  
  # -= Extensions =-
  extend Extensions::Site::SubdomainDomains
  extend Extensions::Site::FirstInstallation
  
  # -= Fields =-
  field :name
  field :robots_txt
  
  # -= Associations =-
  embeds_many :memberships
  has_many :journal_rubrics, :validate => false
  has_many :journal_articles, :validate => false
  has_many :routers, :validate => false
  has_many :media_collections, :validate => false
  has_many :media_files, :validate => false
  
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
  
  def godmode_accounts
    accounts.in(:_id => self.memberships.in(:role => %w(author admin editor)).collect(&:account_id))
  end
  
  def admin_memberships
    self.memberships.find_all { |m| m.admin? }
  end
  
  def sort(type = Array, ids = [])
    type.send(:sort!, ids)
  end
  
  # Fix for routing
  def router
    nil
  end
  
  def find_object_by_path(path)
    routers.where(:url => path).map(&:routerable).first
  end
  
end