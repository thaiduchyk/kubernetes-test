# frozen_string_literal: true

class InventoryWriteoff < PrimaryBase
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :enough_parts

  belongs_to :inventory

  after_create :remove_items_from_inventory

  private

  def remove_items_from_inventory
    new_quantity = inventory.quantity - quantity
    inventory.update!(quantity: new_quantity)
  end

  def enough_parts
    return if inventory.quantity >= quantity

    errors.add(:quantity, 'not enough parts in the inventory for write-off')
  end
end
