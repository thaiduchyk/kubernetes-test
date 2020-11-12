# frozen_string_literal: true

module Legacy
  class OrderItem < LegacyBase
    self.table_name = 'k_INVOICE_ITEM'

    include Importable

    belongs_to :product, class_name: 'Legacy::Product', foreign_key: 'k_PROD_ID'
    belongs_to :order, class_name: 'Legacy::Order', foreign_key: 'k_INVOICE_ID'

    IMPORT_MAP = {
      ::OrderItem => {
        'direct' => {
          'k_ITEM_COST' => 'product_cost',
          'k_SHIPPING_COST' => 'shipping_cost',
          'k_ITEM_QTY' => 'quantity',
          'k_ITEM_TOTAL' => 'product_total',
          'k_ITEM_ID' => 'legacy_id'
        }
      }
    }.freeze

    def import_to_primary
      perform_import do
        order_item = build_object(::OrderItem)
        product = ::Product.find_by(sku: self.product&.PRODUCT_ID)
        order = ::Order.find_by(number: self.order&.k_INVOICE_ID)
        order_item.product = product
        order_item.order = order
        order_item.save!
      end
    end
  end
end
