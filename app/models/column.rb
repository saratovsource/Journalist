class Column
  include Journalist::Document

  # -= Callbacks =-
  before_validation :set_title_and_slug

  include Extensions::Content::BaseFields
  include Extensions::Content::Sortable
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Mongoid::Rateable
  # -= ACLS=-
  include Journalist::Acl
  include Extensions::Acl::Password
  include Extensions::Acl::Time

  # -= Associations =-
  has_many :column_articles, :class_name => "ColumnArticle", :foreign_key => "parent_id"

  # -= Validations =-
  validates :slug, :uniqueness => [:site, :owner]

  def prefix
    "columns"
  end

  def parent
    self.site
  end

  protected

  def set_title_and_slug
    self.title = self.owner.name
  end
end
