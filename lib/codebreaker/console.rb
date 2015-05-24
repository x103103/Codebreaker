require "highline/import"

module Codebreaker
  class Console
    def initialize
      loop do
        ft = HighLine::ColorScheme.new do |cs|
          cs[:white_black] = [ :bold, :white, :on_black]
          cs[:yellow_black] = [ :bold, :yellow, :on_black]
          cs[:yellow] = [ :bold, :yellow]
          cs[:red] = [ :bold, :red]
          cs[:blue] = [ :bold, :blue]
        end

        HighLine.color_scheme = ft

        say "<%= color('-'*41, :white_black) %>"
        say "<%= color('-'*15, :white_black) %><%= color('CODEBREAKER', :yellow_black) %><%= color('-'*15, :white_black) %>"
        say "<%= color('-'*41, :white_black) %>"
        puts ''

        loop do
          answer = ask('Type "start" to start the game or "scores" to show scores')
          if answer[/[Ss][Tt][Aa][Rr][Tt]/]
            break
          elsif answer[/[Ss][Cc][Oo][Rr][Ee][Ss]/]
            puts ''
            scores = Game.load

            say "<%= color('Name', :yellow) %>________<%= color('Attempt', :yellow) %>"
            scores.each do |g|
              _count = 16 - g.user.name.length
              say "<%= color('#{g.user.name}', :blue) %><%= color(' '*#{_count}, :blue) %><%= color('#{g.attempt}', :blue) %>"
            end
            puts ''
            puts ''
          end
        end

        name = ask("Enter your name:")
        puts ''

        user = User.new name
        game = Game.new user

        say "<%= color('The game started!', :yellow) %>"
        puts ''

        result = {}
        hint = ''
        loop do
          answer = ask("Enter a code: (type \"hint\" to see one of number)")

          if answer[/^[1-6]{4}$/]
            result = game.guess answer
            say "<%=color('#{result[:result]}',:blue)%> (attempts remain: #{game.attempts_remain})"
          elsif answer[/[Hh][Ii][Nn][Tt]/]
            if hint.empty?
              position = ask("What number do you want to see?").to_i if hint.empty?
              position -= 1
              hint = game.hint position
            end

            say("Hint: <%=color('#{hint}',:blue)%>")
            next
          elsif answer == 'c' # cheat
            puts game.secret_code.join
            next
          else
            next
          end
          break unless result[:status] == :next
        end

        if result[:status] == :win
          say "<%= color('Congratulate! You win!', :yellow) %>"
          puts ''
        end
        if result[:status] == :game_over
          say "<%= color('Game over!', :red) %>"
          puts ''
        end

        loop do
          answer = ask("Do you want to save your score? [y/n]")
          puts ''
          if answer[/[Yy]/]
            game.save
            break
          elsif answer[/[Nn]/]
            break
          end
        end


        answer = ask("Do you want play again? (type \"no\" for exit)")
        exit if answer[/[Nn][Oo]/]

      end
    end
  end
end