require 'rails_helper'

RSpec.describe Lodge, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'corporate_name is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'brand_name is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'registration_number is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'full_address is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'city is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'state is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'email is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'zip_code is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'contact_number is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'description is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'pets is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'terms_of_service is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'check_in is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'check_out is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'status is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end

      it 'user_id is mandatory' do
        lodge = Lodge.new

        lodge.valid?

        expect(lodge.errors.include? :corporate_name).to be true
      end
    end
  end
end