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
end