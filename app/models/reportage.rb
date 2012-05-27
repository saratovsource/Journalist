class Reportage
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Article::Stated
  include Extensions::Article::Publish
  include Mongoid::Rateable
  include Extensions::Article::Timelinable

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

  # -= Validations =-
  validates_presence_of     :site

  # -= Methods =-
  class << self
    # Create new empty article
    def create_new(args = {})
      args = {
        :title => I18n.t('reportage.default_title'),
        :slug => Journalist::UniqGenerator.generate(:prefix => "reportage")
        }.merge(args)

      create(args)
    end
  end

  def can_state?(state_name)
    case state_name
    when :prepublish
      self.content.present?
    when :publish
      self.content.present?
    else
      true
    end
  end

  protected

  def set_owned_site
    self.site = self.parent.site if self.parent.present?
  end
end
