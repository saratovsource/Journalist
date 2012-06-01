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
  protected

  def has_valid_keys?(section, keys=[:name, :action])
    return false if section.blank?
    ((section.keys & keys) - keys).empty?
  end
end
