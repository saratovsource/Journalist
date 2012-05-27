module Api::MediaCollectionsHelper
  def api_attributes
    [:id, :created_at, :description, :in_robots, :meta_description, :meta_keywords, :owner, :position, :presentable, :seo_title, :site, :slug, :tags]
  end
end
