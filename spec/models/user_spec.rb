require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name is mandatory' do
        user = User.new(name: '', email: 'jose@contato.com', password: 'strongpassword')

        expect(user).not_to be_valid
      end

      it 'email is mandatory' do 
        user = User.new(name: 'José', email: '', password: 'strongpassword')

        expect(user).not_to be_valid
      end

      it 'password is mandatory' do 
        user = User.new(name: 'José', email: 'jose@contato.com', password: '')

        expect(user).not_to be_valid
      end
    end
  end
end