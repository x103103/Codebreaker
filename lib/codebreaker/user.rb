module Codebreaker
  class User
    attr_reader :name
    attr_accessor :attempt

    def initialize(name)
      @name = name
    end
  end
end