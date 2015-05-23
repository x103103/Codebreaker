module Codebreaker
  describe User do
    let(:user) { User.new 'name' }

    it 'have name' do
      expect(user.instance_variable_get(:@name)).not_to be_empty
    end

  end
end