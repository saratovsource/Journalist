class FaceUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/faces/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :resize_to_fill => [220, 330]
  end

  def default_url
    "journalist/" + [version_name, "empty.png"].compact.join('_')
  end
end
