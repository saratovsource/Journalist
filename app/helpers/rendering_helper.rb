module RenderingHelper

  def time_tag(datetime, format = :short)
    content_tag(:time, l(datetime, :format => format), :datetime => datetime)
  end

  def icon_content_tag(icon, name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    [
      content_tag(:i, " ", :class => icon),
      content_tag(name, content_or_options_with_block, options, escape, &block)
      ].join()
  end

  def render_section(section_name)
    return unless @layout_sections.present?
    section = @layout_sections[section_name]
    return unless section.present?
    render_cell section[:name], section[:action], (section[:options] || {}) if has_valid_keys?(section)
  end

  def name_of_user(account)
    account.profile.name || account.name || t(:anonymous)
  end

  def seo_title(item)
    title_text = ""
    if item.respond_to?(:seo_title) && item.seo_title.present?
      title_text =  item.seo_title if item.seo_title.present?
    else
      title_text = (item.title || "").j_clean
    end
    content_tag(:title, [title_text, I18n.t(:site_name) ].join(I18n.t(:title_delimiter)))
  end

  def seo_description(item)
    description_text = ""
    if item.respond_to?(:meta_description) && item.meta_description.present?
      description_text = item.meta_description
    else
      description_text = item.description if item.respond_to?(:description)
    end
    if description_text.blank?
      nil
    else
      tag(:meta, :name => "description", :content => description_text)
    end
  end

  def seo_tags(item)
    ret_value = ""
    if item.respond_to?(:meta_keywords) && item.meta_keywords.present?
      ret_value = item.meta_keywords
    else
      ret_value = item.tags if item.respond_to?(:tags)
    end
    if ret_value.blank?
      nil
    else
      ret_value = ret_value.join(', ') if ret_value.kind_of?(Array)
      tag(:meta, :name => "keywords", :content => ret_value)
    end
  end

  def seo_author(item)
    ret_value = ""
    ret_value = item.owner.name if (item.owner.name.present?)
    if ret_value.blank?
      nil
    else
      tag(:meta, :name => "author", :content => ret_value)
    end
  end
  protected

  def has_valid_keys?(section, keys=[:name, :action])
    return false if section.blank?
    ((section.keys & keys) - keys).empty?
  end
end
