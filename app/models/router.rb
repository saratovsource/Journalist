class Router
  include Journalist::Document
  include Extensions::Site::IncludedIn
  
  # -= Fields =-
  field :url
  
  # -= Associations =-
  belongs_to :routerable, polymorphic: true
  
  # -= Validations =-
  validates_presence_of   :url
  validates_uniqueness_of :url
  
  before_validation       :build_fields_to_save
  
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
      create(:routerable => instance_type)
    end    
  end
  
  protected
  
  def build_fields_to_save
    unless self.routerable.nil?
      self.url = self.routerable.fullpath
      self.site = self.routerable.site
    end
  end
end