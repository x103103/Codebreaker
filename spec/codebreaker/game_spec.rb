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
        before { game.instance_variable_set('@secret_code',['1','2','3','4']) }
        it 'return +++' do
          expect(game.guess '1231').to eq('+++')
        end
        it 'return ++--' do
          expect(game.guess '4231').to eq('++--')
        end
        it 'return +---' do
          expect(game.guess '1423').to eq('+---')
        end
        it 'return ----' do
          expect(game.guess '4321').to eq('----')
        end
        it 'return +++' do
          expect(game.guess '1235').to eq('+++')
        end
        it 'return ++' do
          expect(game.guess '1255').to eq('++')
        end
        //
        it 'return +' do
          expect(game.guess '1555').to eq('+')
        end
        it 'return ---' do
          expect(game.guess '4315').to eq('---')
        end
        it 'return --' do
          expect(game.guess '4355').to eq('--')
        end
        it 'return -' do
          expect(game.guess '4555').to eq('-')
        end
        it 'return ++-' do
          expect(game.guess '1245').to eq('++-')
        end
        it 'return +--' do
          expect(game.guess '1345').to eq('+--')
        end
        it 'return +-' do
          expect(game.guess '1355').to eq('+-')
        end
        it 'return nothing' do
          expect(game.guess '5555').to eq('')
        end
      end
      # it 'change user score'
      # it 'win if all quessed'
      # it 'game over if there no attempt'
    end
  end
end