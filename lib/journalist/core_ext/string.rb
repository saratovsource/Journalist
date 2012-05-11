require 'redcloth'
## String
class String

  def transliterate
    Russian::transliterate(self)
  end

  def permalink
    self.transliterate.parameterize('-')
  end

  def permalink!
    replace(self.permalink)
  end

  def to_textile
    RedCloth.new(self).to_html
  end

  def j_clean
    if self =~ /\*(.*)\*/
      self.gsub(/\*(.*)\*/, $1)
    else
      self
    end
  end

  def to_link(model, options = {})
    if self =~ /\*(.*)\*/
      self.gsub(/\*(.*)\*/, "<a href='#{model.fullpath}'>#{$1}</a>")
    else
      "<a href='#{model.fullpath}'>#{model.title}</a>"
    end
  end

  alias :parameterize! :permalink!

end
