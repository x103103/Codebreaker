module Codebreaker
  class Game
    attr_reader :user, :secret_code


    def initialize(user)
      @user = user
      @secret_code = (1..4).map { rand 1..6 }
      @attempt = 0
      @max_attempt = 10
    end

    def guess(user_code)
      raise ArgumentError, 'Wrong user code' unless user_code.is_a?(String) && user_code[/^[1-6]{4}$/]
      @attempt += 1
      result = compare_code user_code
      result_str = result.join
      if result_str == '++++'
        {result:result_str, status: :win}
      elsif @attempt == @max_attempt
        {result:result_str, status: :game_over}
      else
        {result:result_str, status: :next}
      end
    end

    def hint(position=rand(0..3))
      raise ArgumentError, 'Wrong position' unless position < 4 && position >=0
      hint = '****'
      hint[position] = @secret_code[position]
      hint
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

      user_code_array.compact!; secret_code.compact!

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