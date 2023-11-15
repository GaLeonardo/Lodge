require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'name is mandatory' do
        room = Room.new

        room.valid?

        expect(room.errors.include? :name).to be true
      end

      it 'description is mandatory' do
        room = Room.new

        room.valid?

        expect(room.errors.include? :description).to be true
      end

      it 'area is mandatory' do
        room = Room.new

        room.valid?

        expect(room.errors.include? :area).to be true
      end

      it 'max_people is mandatory' do
        room = Room.new

        room.valid?

        expect(room.errors.include? :max_people).to be true
      end

      it 'standard_price is mandatory' do
        room = Room.new

        room.valid?

        expect(room.errors.include? :standard_price).to be true
      end
    end
  end
end
