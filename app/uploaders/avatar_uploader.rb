class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/avatars/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :resize_to_fill => [30, 30]
  end

  version :big do
    process :resize_to_fill => [220, 400]
  end

  version :column_small do
    process :resize_to_fill => [140, 80]
  end

  def default_url
    "journalist/" + [version_name, "empty.png"].compact.join('_')
  end
end
