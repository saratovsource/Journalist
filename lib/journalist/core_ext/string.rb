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

  alias :parameterize! :permalink!

end