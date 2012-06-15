class Page
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Content::EditableContent
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner

  field :visible, :type => Boolean, :default => false

  validates_uniqueness_of   :slug, :scope => [:site_id]

  scope :web, ->{where(:visible => true)}
  
  def prefix
    nil
  end

  def parent
    self.site
  end

end
