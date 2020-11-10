# frozen_string_literal: true

class Order < PrimaryBase
  include Defaultable

  enum status: {
    novel: 'New',
    pending_us: 'Pending (Us)',
    pending_them: 'Pending (Them)',
    shipped: 'Shipped',
    cancelled: 'Cancelled'
  }

  enum sale_channel: {
    website: 'website',
    ebay: 'ebay',
    amazon: 'amazon',
    other: 'other'
  }

  DEFAULT_VALUES = {
    total: 0,
    shipping_cost: 0,
    tax: 0,
    status: :novel
  }.freeze

  validates :number, presence: true, uniqueness: true
  validates :status, presence: true
  validates :sale_channel, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :tax, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :customer

  has_many :order_items
  has_many :products, through: :order_items
  has_many :payments
  has_many :order_parts
  has_many :parts, through: :order_parts

  def update_order_costs
    self.shipping_cost = order_items.sum(&:shipping_cost)
    self.total = order_items.sum(&:product_total) + shipping_cost
    save
  end
end
