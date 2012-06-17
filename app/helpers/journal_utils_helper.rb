module JournalUtilsHelper

  def name_of_user(user)
    user.profile.name || user.name
  end

  ## SEO ##

  def seo_collection_title(collection, kind)
    content_tag(:title, collection_translate_scope(:title, kind))
  end

  def seo_collection_description(collection, kind)
    tag(:meta, :name => "description", :content => collection_translate_scope(:description, kind))
  end

  def seo_collection_tags(collection)
    tag(:meta, :name => "keywords", :content => collection.join(", "))
  end

  protected

  def collection_translate_scope(name, kind)
    [I18n.t(name, :scope => ["seo", kind.to_s].join('.')), I18n.t(:site_name) ].join(I18n.t(:title_delimiter))
  end

end
