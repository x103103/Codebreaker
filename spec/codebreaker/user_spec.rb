module Codebreaker
  describe User do
    let(:user) { User.new 'name' }

    context '#initialize' do
      it 'have name' do
        expect(user.instance_variable_get(:@name)).not_to be_empty
      end
    end

    context '#to_hash' do
      it 'should return Hash' do
        expect(user.to_hash.class).to eq(Hash)
      end

      it 'should contain name' do
        expect(user.to_hash[:name]).to eq('name')
      end
    end

  end
end