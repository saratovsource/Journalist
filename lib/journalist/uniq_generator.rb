module Journalist
  class UniqGenerator
    include Singleton
    
    CHARS = ['A'..'Z', 'a'..'z', '0'..'9'].map{|r|r.to_a}.flatten
    
    def generate(args = {})
      [
        args[:prefix],
        Array.new(6).map{CHARS[rand(CHARS.size)]}.join,
        args[:postfix]
      ].compact.join(args[:separator] || "-")
    end
    
    class << self
      def generate(args = {})
        instance.generate(args)
      end
    end
  end
end