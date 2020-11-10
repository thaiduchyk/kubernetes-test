# frozen_string_literal: true

class InventorySupply < PrimaryBase
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :value, numericality: true

  belongs_to :inventory

  after_create :add_items_to_inventory

  private

  def add_items_to_inventory
    new_quantity = inventory.quantity + quantity
    inventory.update!(quantity: new_quantity)
  end
end
