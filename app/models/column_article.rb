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
  include Extensions::Article::Timelinable

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
      validates_uniqueness_of   :slug, :scope => [:site_id, :parent_id]
      validates_presence_of :content
    end

  end

  # -= Methods =-
  class << self
    # Create new empty article
    def create_new(args = {})
      args = {
        :title => I18n.t('column_article.default_title'),
        :slug => Journalist::UniqGenerator.generate(:prefix => "post")
        }.merge(args)

      create(args)
    end
  end

  def can_state?(state_name)
    case state_name
    when :prepublish
      self.parent.present?
    when :publish
      self.content.present? and self.parent.present?
    else
      true
    end
  end

  protected

  def set_owned_site
    self.site = self.parent.site if self.parent.present?
  end
end
