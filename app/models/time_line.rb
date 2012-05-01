class TimeLine
  include Journalist::Document
  include Extensions::Site::IncludedIn

  # -= Associations =-
  belongs_to :timelinable, polymorphic: true

  # -= validations=-
  before_validation :set_publish_date, :set_owned_site

  field :published_at, type: DateTime

  protected

  def set_publish_date
    self.published_at = timelinable.published_at if timelinable.present? && timelinable.respond_to?(:published_at)
  end

  def set_owned_site
    self.site = timelinable.site if timelinable.present?
  end
end
