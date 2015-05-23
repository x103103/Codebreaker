module Codebreaker
  class User
    attr_reader :name
    attr_accessor :score, :attempt

    def initialize(name)
      @name = name
      @score = 1000
      @attempt = 0
    end
  end
end