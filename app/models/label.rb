class Label
  include Mongoid::Document

  field :name
  field :css
  field :color

  validates_presence_of :name, :css, :color
  validates :name, :uniqueness => [:css, :color]

  before_validation :strip_name

  protected

  def strip_name
    self.name = self.name.gsub(/\'|\"/, '') if self.name.present?
  end
end
