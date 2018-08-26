module Codebreaker
  class Game
    attr_reader :user, :secret_code, :attempt, :max_attempts, :results, :status,
                :start_time, :end_time



    def initialize(user)
      @user = user
      @secret_code = (1..4).map { rand 1..6 }
      @attempt = 0
      @max_attempts = 10
      @hint = ''
      @results = []
      @status = :next
      @start_time = Time.new
    end

    def guess(user_code)
      raise ArgumentError, 'Wrong user code' unless user_code.is_a?(String) && user_code[/^[1-6]{4}$/]
      @attempt += 1
      result = compare_code user_code
      @results << result.join
      if @results.last == '++++'
        @status = :win
        @end_time = Time.new
        game_duration
      elsif @attempt == @max_attempts
        @status = :game_over
      else
        @status = :next
      end
      self
    end

    def remaining_attempts
      @max_attempts - @attempt
    end

    def game_duration
      (@game_duration ? @game_duration : @game_duration = ((@end_time - @start_time)/60).to_i) if @status == :win
    end

    def hint(position=rand(0..3))
      raise TypeError, 'Wrong position type' unless position.is_a? Integer
      return @hint unless @hint.empty?
      position = 3 if position > 3
      position = 0 if position < 0
      hint = '****'
      hint[position] = @secret_code[position].to_s
      @hint = hint
    end

    def save(file = 'history')
      games = Game.load
      games << self
      f = File.open(file, "w")
      f.write(Marshal.dump(games))
      f.close
    end

    def to_hash
      {
          user: @user.to_hash,
          remaining_attempts: remaining_attempts,
          attempt: @attempt,
          max_attempts: @max_attempts,
          hint: @hint,
          results: @results,
          status: @status,
          game_duration: @game_duration
      }
    end

    class << self

      def load(file = 'history')
        if File.exist? file
          dump_data = File.read(file)
          Marshal.load(dump_data)
        else
          []
        end
      end

    end

    private
    def compare_code(user_code)
      user_code_array = user_code.split('')
      user_code_array.map! {|item| item.to_i}
      secret_code = @secret_code.clone
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
