require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name is mandatory' do
        user = User.new

        user.valid?

        expect(user.errors.include? :name).to be true
      end

      it 'email is mandatory' do 
        user = User.new

        user.valid?

        expect(user.errors.include? :email).to be true
      end

      it 'password is mandatory' do 
        user = User.new

        user.valid?

        expect(user.errors.include? :password).to be true
      end
    end
  end
end