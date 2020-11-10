# frozen_string_literal: true

class OrderPart < PrimaryBase
  validates :quantity, numericality: { only_integer: true, other_than: 0 }
  validates :part, uniqueness: { scope: :order_id, message: 'this part is already linked to order' }

  belongs_to :order
  belongs_to :part
end
