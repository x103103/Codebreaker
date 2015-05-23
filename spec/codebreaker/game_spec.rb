module Codebreaker
  describe Game do
    let(:game) { Game.new User.new('name') }
    context '#initialize' do

      it 'generates secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code)).to have(4).items
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code).join).to match(/[1-6]+/)
      end

      it 'receives user' do
        expect(game.instance_variable_get(:@user).is_a? User).to be_truthy
      end

    end

    context '#guess' do

      context 'error if user code' do
        it 'not a String' do
          expect{game.guess 1234}.to raise_error(ArgumentError, 'Wrong code')
        end

        it 'length is less than 4' do
          expect{game.guess '123'}.to raise_error(ArgumentError, 'Wrong code')
        end

        it 'length is more than 4' do
          expect{game.guess '123456'}.to raise_error(ArgumentError, 'Wrong code')
        end

        it 'include numbers not between 1-6' do
          expect{game.guess '1237'}.to raise_error(ArgumentError, 'Wrong code')
        end
      end


      context 'compare secret code with user code' do
        it 'return ++++'
        it 'return +++-'
        it 'return ++--'
        it 'return +---'
        it 'return ----'
        it 'return +++'
        it 'return ++'
        it 'return +'
        it 'return ---'
        it 'return --'
        it 'return -'
        it 'return ++-'
        it 'return +--'
        it 'return +-'
        it 'return nothing'
      end
      it 'change user score'
      it 'win if all quessed'
      it 'game over if there no attempt'
    end
  end
end