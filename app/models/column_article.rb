class ColumnArticle
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Content::EditableContent
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Auth::Partners
  include Extensions::Article::Stated
  include Extensions::Article::Publish
  include Extensions::Stick::Stickers

  # -= Associations =-
  belongs_to :parent, :class_name => "Column"

  # -= Indexes =-
  index :parent_id

  # -= Validations =-
  validates_presence_of     :site

  # -= Callbacks =-
  before_validation :set_owned_site

end
