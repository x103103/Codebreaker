module Codebreaker
  describe Game do
    context "#start" do
      let(:game) { Game.new }

      before do
        game.start
      end

      it "generates secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code)).to have(4).items
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret_code).join).to match(/[1-6]+/)
      end
    end
  end
end