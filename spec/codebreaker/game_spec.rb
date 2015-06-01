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

      it 'have number of max attempt' do
        expect(game.instance_variable_get(:@max_attempts)).to eq(10)
      end

      it 'have collection of user guesses result' do
        expect(game.instance_variable_get(:@results).class).to eq(Array)
      end

      it 'have status' do
        expect(game.instance_variable_get(:@status)).to eq(:next)
      end

    end

    context '#guess' do
      before { game.instance_variable_set('@secret_code',[1,2,3,4]) }

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
        guesses = {
            '1234'=>'++++',
            '4231'=>'++--',
            '1423'=>'+---',
            '4321'=>'----',
            '1235'=>'+++',
            '1255'=>'++',
            '1555'=>'+',
            '4315'=>'---',
            '4355'=>'--',
            '4555'=>'-',
            '1245'=>'++-',
            '1345'=>'+--',
            '1355'=>'+-',
            '5555'=>''
        }
        guesses.each do |guess,result|
          it "return #{result}" do
            game.guess(guess)
            expect(game.results.last).to eq(result)
          end
        end

      end

      context 'status' do
        it 'win if all quessed' do
          game.guess('1234')
          expect(game.status).to eq(:win)
        end
        it 'game over if there no attempt' do
          game.instance_variable_set('@attempt',9)
          game.guess('5555')
          expect(game.status).to eq(:game_over)
        end
        it 'next if there is attempt' do
          game.instance_variable_set('@attempt',0)
          game.guess('5555')
          expect(game.status).to eq(:next)
        end
      end

    end

    context '#hint' do
      before { game.instance_variable_set('@secret_code',[1,2,3,4]) }

      it 'return 1***' do
        expect(game.hint 0).to eq('1***')
      end

      it 'return ***4' do
        expect(game.hint 3).to eq('***4')
      end

      context 'error if position' do
        it 'not a number' do
          expect{game.hint('d')}.to raise_error(TypeError, 'Wrong position type')
        end
      end
    end

    context '#remaining_attempts' do
      it 'return difference of max and current attempt' do
        game.instance_variable_set('@attempt',1)
        expect(game.remaining_attempts).to eq(9)
      end
    end

    context '#to_hash' do
      it 'should return Hash' do
        expect(game.to_hash.class).to eq(Hash)
      end

      it 'should contain user hash' do
        allow(game.user).to receive(:to_hash).and_return({name:'name'})
        expect(game.to_hash[:user]).to eq({name:'name'})
      end

      it 'should contain remaining attempts' do
        expect(game.to_hash[:remaining_attempts]).to eq(10)
      end

      it 'should contain attempt' do
        expect(game.to_hash[:attempt]).to eq(0)
      end

      it 'should contain max attempts' do
        expect(game.to_hash[:max_attempts]).to eq(10)
      end

      it 'should contain hint' do
        game.instance_variable_set('@hint','***1')
        expect(game.to_hash[:hint]).to eq('***1')
      end

      it 'should contain results' do
        game.instance_variable_set('@results',['+-'])
        expect(game.to_hash[:results]).to eq(['+-'])
      end

      it 'should contain status' do
        expect(game.to_hash[:status]).to eq(:next)
      end
    end
  end
end