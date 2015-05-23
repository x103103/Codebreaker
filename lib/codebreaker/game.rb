module Codebreaker
  class Game
    attr_reader :user, :secret_code


    def initialize(user)
      @user = user
      @secret_code = (1..4).map { rand 1..6 }
    end

    def guess(user_code)
      raise ArgumentError, 'Wrong code' unless user_code.is_a?(String) && user_code[/^[1-6]{4}$/]
      result = compare_code user_code
      result.join
    end

    private
    def compare_code(user_code)
      user_code_array = user_code.split('')
      secret_code = @secret_code
      result = []

      4.times do |i|
        if user_code_array[i] == secret_code[i]

          result << '+'
          user_code_array[i] = nil
          secret_code[i] = nil
        end
      end

      user_code_array.compact!; secret_code.compact!;

      user_code_array.each_index do |user_i|
        secret_code.each_index do |secret_i|

          if user_code_array[user_i] == secret_code[secret_i]
            result << '-'
            secret_code[secret_i] = nil
          end

        end
      end

      result

    end
  end

end