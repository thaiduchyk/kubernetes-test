# frozen_string_literal: true

class OrderItem < PrimaryBase
  include Defaultable

  DEFAULT_VALUES = {
    shipping_cost: 0
  }.freeze

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :product_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :product_total, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :order
  belongs_to :product, optional: true

  after_save :calculate_order_values

  private

  def calculate_order_values
    order.update_order_costs
  end
end
