class Face
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Article::Stated
  include Extensions::Article::Publish
  include Extensions::Article::Timelinable

  # -= Fields =-
  field :sex, default: "m"

  # -= Associations =-
  belongs_to :parent, :class_name => "Column"

  # -= Indexes =-
  index :parent_id

  # -= Validations =-
  validates_presence_of     :site

  # -= Callbacks =-
  before_validation :set_owned_site

  #-= States =-
  state_machine do

    state all - [:drafted, :trashed] do
      validates_presence_of     :parent
      validates_uniqueness_of   :slug, :scope => [:site_id]
    end

  end

  def prefix
    "facepatrol"
  end

  def parent
    self.site
  end

end
