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

  belongs_to :moderator, :class_name => "Account"

  before_validation :autogenerate_title
  validates_presence_of   :message

  scope :revert, ->{desc(:created_at)}
  scope :ordered, ->{asc(:created_at)}
  scope :web, ->{where(:message.ne => nil).without_state(:hidden).ordered}

  state_machine :initial => :visible do
    state :visible
    state :ambiguous
    state :hidden

    event :publish do transition all => :visible
    end 
    event :doubt do
      transition all => :ambiguous
    end

    event :hide do
      transition all => :hidden
    end
  end

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
