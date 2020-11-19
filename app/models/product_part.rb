# frozen_string_literal: true

class ProductPart < PrimaryBase
  validates :quantity, numericality: { only_integer: true, other_than: 0 }
  validates :part, uniqueness: { scope: :product_id, message: 'this part is already linked to product' }

  belongs_to :product
  belongs_to :part

  def soft_delete
    update(deleted_at: Time.current)
  end
end
