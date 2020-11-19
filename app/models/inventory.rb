# frozen_string_literal: true

class Inventory < PrimaryBase
  enum location: {
    home: 'home',
    storage: 'storage'
  }

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :location, presence: true, uniqueness: { scope: :part_id, message: 'inventory for this part and location already exists'}

  belongs_to :part
  has_many :inventory_supplies
  has_many :from_transitions, class_name: 'InventoryTransition', foreign_key: :from_inventory_id
  has_many :to_transitions, class_name: 'InventoryTransition', foreign_key: :to_inventory_id
  has_many :inventory_writeoffs
  has_many :shipment_parts
end
