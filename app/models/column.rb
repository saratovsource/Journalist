class Column
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
  has_many :column_articles, :class_name => "ColumnArticle", :foreign_key => "parent_id"

  def prefix
    "columns"
  end

  def parent
    self.site
  end
end
