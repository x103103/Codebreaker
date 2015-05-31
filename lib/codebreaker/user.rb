module Codebreaker
  class User
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def to_hash
      {
          name:@name
      }
    end
  end
end