# frozen_string_literal: true

class ShipmentPart < PrimaryBase
  DEFAULT_INVENTORY_LOCATION = Inventory.locations[:home]

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :not_placeholder_part
  validate :enough_parts

  belongs_to :shipment
  belongs_to :part
  belongs_to :inventory, optional: true

  before_create :set_inventory
  after_create :remove_items_from_inventory

  private

  def enough_parts
    return unless part
    return if part.placeholder
    return if part.direct_shipment
    return if inventory.quantity >= quantity

    errors.add(:quantity, 'not enough parts in the inventory for shipment')
  end

  def not_placeholder_part
    return unless part&.placeholder

    errors.add(:part, 'placeholder part can not be shipped')
  end

  def set_inventory
    return if part.direct_shipment

    self.inventory = Inventory.find_by(part_id: part_id, location: DEFAULT_INVENTORY_LOCATION)
  end

  def remove_items_from_inventory
    return if part.direct_shipment

    new_quantity = inventory.quantity - quantity
    inventory.update!(quantity: new_quantity)
  end
end
