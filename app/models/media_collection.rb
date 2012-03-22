class MediaCollection
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Content::Sortable
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  # -= ACLS=-
  include Journalist::Acl
  include Extensions::Acl::Password
  include Extensions::Acl::Time
  
  # -= Associations =-
  has_many :media_files
  
  # -= Validations =-
  validates_uniqueness_of   :slug, :scope => [:site_id]
  
  accepts_nested_attributes_for :media_files
  
  cachable :media_files
  
  class << self
    # Create new empty rubric
    def create_new(args = {})
      args = {
        :title => Journalist::UniqGenerator.generate(:prefix => self.model_name.human)
        }.merge(args)
        
      create(args)
    end
    
  end
  
  def parent
    self.site
  end
  
  def prefix
    "collections"
  end
  
  def parent_path
    "/#{prefix}"
  end
  
  def poster_url
    self.media_files.empty? ? "journalist/empty.png" : self.media_files.first.file.poster_thumb.url
  end
  
end