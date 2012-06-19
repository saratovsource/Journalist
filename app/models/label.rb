class Label
  include Mongoid::Document

  field :name
  field :css
  field :color

  belongs_to :site
  # -= Indexes=-
  index :site_id

  validates_presence_of :name, :css, :color
  validates :name, :uniqueness => [:css, :color]

  before_validation :strip_name

  class << self
    def comment_label
      where(:css => "comment")
    end

    def like_label
      where(:css => "heart")
    end

  end

  protected

  def strip_name
    self.name = self.name.gsub(/\'|\"/, '') if self.name.present?
  end
end
