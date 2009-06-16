require 'ruby/node'

module Ruby
  class Token < Node 
    attr_accessor :token

    def initialize(token, position = nil, whitespace = nil)
      self.token = token
      super(position, whitespace)
    end
    
    def to_ruby(include_whitespace = false)
      (include_whitespace ? whitespace : '') + token.to_s
    end
      
    def to_identifier
      Identifier.new(token, position, whitespace) 
    end
  end
  
  class Keyword < Token
  end

  class Variable < Token
  end
  
  class Identifier < Token
    def to_variable
      Variable.new(token, position, whitespace) 
    end
  end
end