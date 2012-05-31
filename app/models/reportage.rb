class Reportage
  include Journalist::Document
  include Extensions::Content::BaseFields
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Stick::Stickers
  include Extensions::Article::Stated
  include Extensions::Article::Publish
  include Mongoid::Rateable
  include Extensions::Article::Timelinable

  # -= Fields =-
  field :content

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

  def images
    @images ||= retrive_images
  end

  def prefix
    "reportage"
  end

  def parent
    self.site
  end

  def description
    self.meta_description
  end

  def to_html(fname = :content, args = nil)
    "PARSE IMAGES"
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

  def retrive_images
    ret ||= []
    self.content.each_line do |line|
      obj = self.site.find_object_by_path(line.gsub(/\r\n?/, ""))
      p line
      case obj
      when MediaFile
        ret << obj
      when MediaCollection
        ret << obj.media_files
      else
        #nothing
      end
    end
    ret.flatten.compact
  end


end
