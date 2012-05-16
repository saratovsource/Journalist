class TimeLine
  include Journalist::Document
  include Extensions::Site::IncludedIn

  # -= Associations =-
  belongs_to :timelinable, polymorphic: true

  # -= validations=-
  before_validation :set_owned_site, :set_state

  field :published_at, type: DateTime
  field :state
  field :rating

  scope :published, where(:state => "published")
  scope :feed, Proc.new{|date| published.where(date.present? ? {:published_at.lte => date.end_of_day, :published_at.gte => date.beginning_of_day} : {:published_at.lte => date || Time.now}).desc(:published_at)}
  scope :rated, ->{ where(:rating.gte => 1) }

  protected

  def set_owned_site
    self.site = timelinable.site if timelinable.present?
  end

  def set_state
    self.state = self.timelinable.state if self.timelinable.respond_to?(:state)
    self.rating = self.timelinable.try(:rating) || 0
  end
end
