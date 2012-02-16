class Router
  include Journalist::Document
  include Extensions::Site::IncludedIn
  include Mongoid::Tree
  
  # -= Fields =-
  field :slug
  field :prefix
  field :postfix
  field :url
  
  # -= Associations =-
  belongs_to :routerable, polymorphic: true
  
  # -= Validations =-
  validates_presence_of   :url, :slug
  validates_uniqueness_of :url
  
  before_validation       :build_fields_to_save
  after_save              :rebuild_childrens
  
  # -= Indexes =-
  index(
      [
        [:url, Mongo::ASCENDING],
        [:site_id, Mongo::ASCENDING]
      ],
      unique: true
    )
  
  # -= Methods =-
  
  class << self
    def register_instance(instance_type)
      create!(:routerable => instance_type)
    end    
  end
  
  def fullpath
    return self.url
  end
  
  def parent_url
    return parent.nil? ? nil : parent.fullpath
  end
  
  def rebuild_path
    tmp_path = [self.parent_url, self.prefix, self.slug, self.postfix].compact.join('/')
    if self.parent.nil?
      self.url = ['/', tmp_path].compact.join
    else
      self.url = tmp_path
    end
  end
  
  
  
  def rebuild_childrens
    self.children.each do |child|
      child.save
    end
  end
  
  protected
  
  def build_fields_to_save
    unless self.routerable.nil?
      self.slug = self.routerable.slug
      self.site = self.routerable.site
      self.prefix = self.routerable.prefix if self.routerable.respond_to?(:prefix)
      self.postfix = self.routerable.postfix if self.routerable.respond_to?(:postfix)
      #retrive parent
      unless self.routerable.parent.nil?
        self.parent = self.routerable.parent.router
      end
      rebuild_path
    end
  end
end