module Codebreaker
  describe Game do
    context '#start' do
      let(:game) { Game.new }

      before do
        game.start
      end

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

      it 'have score' do
        expect(game.instance_variable_get(:@score)).to eq(1000)
      end
    end

    context '#guess' do
      it 'receive user code'
      context 'compare secret code with user code'
      it 'change user score'
      it 'win if all quessed'
      it 'game over if there no attempt'
    end
  end
end