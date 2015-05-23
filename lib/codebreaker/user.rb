module Codebreaker
  class User
    attr_accessor :score
    attr_reader :name

    def initialize(name)
      @name, @score = name, 0
    end
  end
end