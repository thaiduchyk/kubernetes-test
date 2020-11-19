# frozen_string_literal: true

class Product < PrimaryBase
  include Defaultable

  DEFAULT_VALUES = {
    enabled: true
  }.freeze

  validates :sku, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_price, numericality: { greater_than_or_equal_to: 0 }

  has_many :order_items
  has_many :orders, through: :order_items
  has_many :product_parts
  has_many :parts, through: :product_parts
end
