class Profile
  include Journalist::Document
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner
  include Extensions::Site::Routerable
  include Extensions::Content::Renderable

  field :name, :type => String
  field :about_me, :type => String
  field :city, :type => String
  field :country, :type => String
  # -= CarrierWave =-
  mount_uploader :avatar, AvatarUploader

  def parent
    self.site
  end

  def is_empty?
    self.name.empty?
  end

  def prefix
    I18n.t(:profileslug)
  end

  def parent_path
    "/#{prefix}"
  end

  protected

  def normalize_slug
    self.slug = self.owner.name.clone if self.slug.blank? && self.owner.name.present?
    self.slug.permalink! if self.slug.present?
  end
end
