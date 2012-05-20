class Comment
  include Journalist::Document
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Content::Renderable
  include Mongoid::Taggable
  include Mongoid::Tree
  include Mongoid::Rateable

  field :title
  field :message

  belongs_to :commentable, polymorphic: true

  before_validation :autogenerate_title

  scope :web, ->{asc(:created_at)}

  ## Fix for validation chain ##
  include Extensions::Site::Routerable

  protected

  def override_route_path
    if commentable.fullpath
      "#{commentable.fullpath.gsub(/^\//, '')}##{slug}"
    else
      "#{commentable.fullpath}##{slug}"
    end
  end

  def set_default_marker
    self.cache_marker = [commentable.fullpath, Time.now.nsec].join('-')
  end

  def autogenerate_title
    if self.owner
      self.title = "#{I18n.t("i_generators.comments.title")}-#{self.owner.comments.count + 1}"
    end
  end

end
