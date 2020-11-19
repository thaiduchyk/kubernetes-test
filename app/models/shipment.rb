# frozen_string_literal: true

class Shipment < PrimaryBase
  enum status: {
    in_transit: 'In transit',
    delivered: 'Delivered',
    delivery_failed: 'Delivery failed'
  }

  validates :status, presence: true

  belongs_to :order
  has_many :shipment_parts
end
