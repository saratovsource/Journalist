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

  alias :parameterize! :permalink!

end