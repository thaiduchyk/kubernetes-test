# frozen_string_literal: true

class InventoryTransition < PrimaryBase
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :same_part
  validate :enough_parts

  belongs_to :from_inventory, class_name: 'Inventory'
  belongs_to :to_inventory, class_name: 'Inventory'

  after_create :move_items_between_inventories

  private

  def same_part
    return if from_inventory.part_id == to_inventory.part_id

    errors.add(:base, 'inventory transition should be done for same part')
  end

  def enough_parts
    return if from_inventory.quantity >= quantity

    errors.add(:quantity, 'not enough parts in the inventory for transition')
  end

  def move_items_between_inventories
    PrimaryBase.transaction do
      new_from_quantity = from_inventory.quantity - quantity
      from_inventory.update!(quantity: new_from_quantity)
      new_to_quantity = to_inventory.quantity + quantity
      to_inventory.update!(quantity: new_to_quantity)
    end
  end
end
