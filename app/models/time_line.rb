class TimeLine
  include Journalist::Document
  include Extensions::Site::IncludedIn

  # -= Associations =-
  belongs_to :timelinable, polymorphic: true

  # -= validations=-
  before_validation :set_owned_site, :set_state

  field :published_at, type: DateTime
  field :state

  scope :published, where(:state => "published")
  scope :feed, ->{published.where(:published_at.lte => Time.now)}

  protected

  def set_owned_site
    self.site = timelinable.site if timelinable.present?
  end

  def set_state
    self.state = self.timelinable.state if self.timelinable.respond_to?(:state)
  end
end
