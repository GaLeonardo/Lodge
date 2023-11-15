require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'lodge is mandatory' do
        payment_method = PaymentMethod.new

        payment_method.valid?

        expect(payment_method.errors.include? :lodge).to be true
      end

      it 'returns true if at least one payment method is selected' do
        payment_method = PaymentMethod.new

        payment_method.valid?

        expect(payment_method.errors.include? :payment_method).to be true
      end
    end
  end
end
