module Codebreaker
  class Game
    attr_reader :user, :secret_code


    def initialize(user)
      @user = user
      @secret_code = (1..4).map { rand 1..6 }
    end

    def guess user_code
      raise ArgumentError, 'Wrong code' unless user_code.is_a?(String) && user_code[/^[1-6]{4}$/]
      user_code
    end

  end

end