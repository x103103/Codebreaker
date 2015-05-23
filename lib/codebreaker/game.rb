module Codebreaker
  class Game
    def initialize
      @secret_code = ''
      @score = 0
      @attempt = 0
    end

    def start
      @secret_code = (1..4).map { rand 1..6 }
    end
  end
end