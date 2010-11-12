module Relish
  module StringExtensions
    def extract_option
      split(':')[1]
    end
    
    def remove_option
      split(':')[0]
    end
  end
end

class String
  include Relish::StringExtensions
end