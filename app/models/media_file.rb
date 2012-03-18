class MediaFile
  include Rails.application.routes.url_helpers
  include Journalist::Document
  include Extensions::Content::Cacheble # For caching render elements
  include Extensions::Content::BaseFields
  include Extensions::Content::Sortable
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  
  # -= Fields =-
  field :file
  field :width,  :type => Integer
  field :height, :type => Integer
  
  # -= CarrierWave =-
  mount_uploader :file, FileUploader
  
  # -= Associations =-
  belongs_to :media_collection
  
  # -= Validations =-
  validates_presence_of     :media_collection
  validates_uniqueness_of   :slug, :scope => [:media_collection_id]
  
  def parent
    self.media_collection
  end
  
  protected
  
  def normalize_slug
    self.slug = self.file.filename if self.slug.blank? && self.file.present?
    #self.slug.permalink! if self.slug.present?
  end
  
end