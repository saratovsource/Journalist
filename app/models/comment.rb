class Comment
  include Journalist::Document
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Content::Renderable
  include Mongoid::Taggable
  include Mongoid::Tree
  include Mongoid::Rateable
  include Extensions::Content::Commentable

  field :title
  field :message

  belongs_to :commentable, polymorphic: true

  before_validation :autogenerate_title
  validates_presence_of   :message

  scope :web, ->{where(:message.ne => nil).asc(:created_at)}

  ## Fix for validation chain ##
  include Extensions::Site::Routerable

  protected

  def override_route_path
    ret = "#{root.commentable.fullpath.gsub(/^\//, '')}##{slug}"
    unless parent.nil?
      ret = "/#{ret}"
    end
    ret
  end

  #def override_route_path
  #  if root.commentable.fullpath[0] == '/'
  #    "#{root.commentable.fullpath.gsub(/^\//, '')}##{slug}"
  #  else
  #    "#{root.commentable.fullpath}##{slug}"
  #  end
  #end

  #def override_route_path
  #  "#{root.commentable.fullpath}##{slug}"
  #end

  def set_default_marker
    self.cache_marker = [commentable.fullpath, Time.now.nsec].join('-')
  end

  def autogenerate_title
    if self.owner
      self.title = "#{I18n.t("i_generators.comments.title")}-#{self.owner.comments.count + 1}"
    end
  end

end
