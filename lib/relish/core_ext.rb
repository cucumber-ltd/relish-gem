module Relish
  module StringExtensions
    def extract_option
      include?(':') ? split(':')[1] : self
    end
    
    def without_option
      split(':')[0]
    end
    
    def has_option?
      include?(':')
    end
  end
end

class String
  include Relish::StringExtensions
end