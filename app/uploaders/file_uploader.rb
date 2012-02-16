class FileUploader < CarrierWave::Uploader::Base
  def store_dir
    "#{model.parent.prefix}/#{model.parent.slug}"
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
  
  protected
  
  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end
end