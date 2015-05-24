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

      it 'have number of attempt' do
        expect(game.instance_variable_get(:@attempt)).to eq(0)
      end

    end

    context '#guess' do
      before { game.instance_variable_set('@secret_code',['1','2','3','4']) }

      context 'error if user code' do
        it 'not a String' do
          expect{game.guess 1234}.to raise_error(ArgumentError, 'Wrong user code')
        end

        it 'length is less than 4' do
          expect{game.guess '123'}.to raise_error(ArgumentError, 'Wrong user code')
        end

        it 'length is more than 4' do
          expect{game.guess '123456'}.to raise_error(ArgumentError, 'Wrong user code')
        end

        it 'include numbers not between 1-6' do
          expect{game.guess '1237'}.to raise_error(ArgumentError, 'Wrong user code')
        end
      end

      context 'compare secret code with user code' do
        it 'return ++++' do
          expect(game.guess('1234')[:result]).to eq('++++')
        end
        it 'return ++--' do
          expect(game.guess('4231')[:result]).to eq('++--')
        end
        it 'return +---' do
          expect(game.guess('1423')[:result]).to eq('+---')
        end
        it 'return ----' do
          expect(game.guess('4321')[:result]).to eq('----')
        end
        it 'return +++' do
          expect(game.guess('1235')[:result]).to eq('+++')
        end
        it 'return ++' do
          expect(game.guess('1255')[:result]).to eq('++')
        end
        it 'return +' do
          expect(game.guess('1555')[:result]).to eq('+')
        end
        it 'return ---' do
          expect(game.guess('4315')[:result]).to eq('---')
        end
        it 'return --' do
          expect(game.guess('4355')[:result]).to eq('--')
        end
        it 'return -' do
          expect(game.guess('4555')[:result]).to eq('-')
        end
        it 'return ++-' do
          expect(game.guess('1245')[:result]).to eq('++-')
        end
        it 'return +--' do
          expect(game.guess('1345')[:result]).to eq('+--')
        end
        it 'return +-' do
          expect(game.guess('1355')[:result]).to eq('+-')
        end
        it 'return nothing' do
          expect(game.guess('5555')[:result]).to eq('')
        end
      end

      context 'status' do
        it 'win if all quessed' do
          expect(game.guess('1234')[:status]).to eq(:win)
        end
        it 'game over if there no attempt' do
          game.instance_variable_set('@attempt',9)
          expect(game.guess('5555')[:status]).to eq(:game_over)
        end
        it 'next if there is attempt' do
          game.instance_variable_set('@attempt',0)
          expect(game.guess('5555')[:status]).to eq(:next)
        end
      end

    end

    context '#hint' do
      before { game.instance_variable_set('@secret_code',['1','2','3','4']) }

      it 'return 1***' do
        expect(game.hint 0).to eq('1***')
      end

      it 'return ***4' do
        expect(game.hint 3).to eq('***4')
      end

      context 'error if position' do
        it 'more than 3' do
          expect{game.hint 4}.to raise_error(ArgumentError, 'Wrong position')
        end

        it 'length is less than 0' do
          expect{game.hint(-1)}.to raise_error(ArgumentError, 'Wrong position')
        end
      end
    end
  end
end