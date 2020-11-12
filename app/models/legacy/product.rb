# frozen_string_literal: true

module Legacy
  class Product < LegacyBase
    self.table_name = 'products'

    include Importable

    IMPORT_MAP = {
      ::Product => {
        'direct' => {
          'PRODUCT_ID' => 'sku',
          'PRODUCT_SHORT_DESC' => 'name',
          'PRODUCT_LONG_DESC' => 'description',
          'PRODUCT_COST_R' => 'price',
          'PRODUCT_COST_SHIP' => 'shipping_price',
          'PRODUCT_BUY_LINK' => 'buy_link',
          'PRODUCT_PAGE_CANOE' => 'page_canoe',
          'PRODUCT_PAGE_KAYAK' => 'page_kayak',
          'PRODUCT_PAGE_INFLATABLE' => 'page_inflatable',
          'PRODUCT_PAGE_BOATS' => 'page_boats',
          'PRODUCT_PAGE_PARTS' => 'page_parts',
          'PRODUCT_PAGE_PLANS' => 'page_plans',
          'PRODUCT_IMG_PATH' => 'image_path',
          'PRODUCT_IMG_NAME' => 'image_name',
          'INCLUDE_IN_FEED' => 'include_in_feed'
        }
      }
    }.freeze

    def import_to_primary
      perform_import do
        product = build_object(::Product)
        product.save!
      end
    end
  end
end
