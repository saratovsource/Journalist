class Face
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Article::Stated
  include Extensions::Article::Publish
  include Mongoid::Rateable
  #include Extensions::Article::Timelinable

  # -= Fields =-
  field :sex, default: "m"
  field :file
  field :age, type: Integer

  # -= scopes =-
  scope :boys, where(:sex => 'm')
  scope :girls, where(:sex => 'f')

  # -= CarrierWave =-
  mount_uploader :file, FaceUploader

  # -= Associations =-
  #belongs_to :parent, :class_name => "Site"

  # -= Indexes =-
  index :parent_id

  # -= Callbacks =-
  before_create :set_title_and_slug

  # -= Validations =-
  validates :slug, :uniqueness => [:site]

  #-= States =-
  state_machine do

    state all - [:drafted, :trashed] do
      validates_presence_of     :parent
    end

  end

  def prefix
    "face-patrol"
  end

  def parent
    self.site
  end

  def can_state?(state_name)
    self.file?
  end

  protected

  def set_title_and_slug
    self.title = I18n.t('face_patrol.default_title')
    self.slug = Journalist::UniqGenerator.generate(:prefix => "face")
  end

end
