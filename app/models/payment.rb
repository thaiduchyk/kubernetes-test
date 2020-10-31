# frozen_string_literal: true

class Payment < PrimaryBase
  enum payment_type: {
    card: 'card',
    cash: 'cash',
    check: 'check',
    paypal: 'paypal'
  }

  validates :payment_type, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :order
end
