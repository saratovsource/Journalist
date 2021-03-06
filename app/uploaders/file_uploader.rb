class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  def store_dir
    [:prefix, :slug].map{|i| i = model.parent.try(i)}.join('/')# "#{model.parent.prefix}/#{model.parent.slug}"
  end

  def filename
    "#{super.gsub(File.extname(super), "").permalink!}-#{timestamp}.#{file.extension}" if original_filename.present?
  end

  process :store_model_name

  def store_model_name
    if @file and model
      model.title = filename
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :mini_thumb do
    #process :resize_to_fill => [90, 64]
    process :resize_to_fill => [130, 92]
  end

  version :poster_thumb do
    process :resize_to_fill => [210, 150]
  end

  version :block_list do
    process :resize_to_fill => [132, 88]
  end

  protected

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end
end
