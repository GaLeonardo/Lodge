class PaymentMethod < ApplicationRecord
  belongs_to :lodge
  validate :atleast_one_is_checked

  private

  def atleast_one_is_checked
    unless bank_transfer || credit_card || debit_card || cash || deposit
      errors.add('Pousada', 'deve ter ao menos um método de pagamento.')
    end
  end
end
