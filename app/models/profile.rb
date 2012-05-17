class Profile
  include Journalist::Document
  include Extensions::Site::IncludedIn
  include Extensions::Auth::HasOwner

  field :name, :type => String
  field :about_me, :type => String
  field :city, :type => String
  field :country, :type => String
  # -= CarrierWave =-
  mount_uploader :avatar, AvatarUploader

  def is_empty?
    self.name.empty?
  end
end
