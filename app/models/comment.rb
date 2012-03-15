class Comment
  include Journalist::Document
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Mongoid::Taggable
  include Mongoid::Tree
  
  field :title
  field :message
  
  belongs_to :routerable, polymorphic: true
  belongs_to :commentable, polymorphic: true
  
  before_validation :autogenerate_title
  
  ## Fix for validation chain ##
  include Extensions::Site::Routerable
  
  protected
  
  def autogenerate_title
    if self.owner
      self.title = "#{I18n.t("i_generators.comments.title")}-#{self.owner.comments.count + 1}"
    end
  end
end