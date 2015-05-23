module Codebreaker
  describe User do
    let(:user) { User.new 'name' }

    it 'should have name' do
      expect(user.instance_variable_get(:@name)).not_to be_empty
    end

    it 'should have score' do
      expect(user.instance_variable_get(:@score).is_a? Integer).to be_truthy
    end

  end
end