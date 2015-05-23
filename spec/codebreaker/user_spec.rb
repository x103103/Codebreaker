module Codebreaker
  describe User do
    let(:user) { User.new 'name' }

    it 'have name' do
      expect(user.instance_variable_get(:@name)).not_to be_empty
    end

    it 'have number of attempt' do
      expect(user.instance_variable_get(:@attempt)).to eq(0)
    end

    it 'have score' do
      expect(user.instance_variable_get(:@score)).to eq(1000)
    end

  end
end