module RenderingHelper
  
  def time_tag(datetime, format = :short)
    content_tag(:time, l(datetime, :format => format), :datetime => datetime)
  end
end