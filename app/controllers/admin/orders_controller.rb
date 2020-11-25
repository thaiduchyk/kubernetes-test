# frozen_string_literal: true

module Admin
  class OrdersController < BaseController
    enable_query_filters %w[number status sale_channel]
    enable_expand_fields customer: :internal, shipping_address: :internal, billing_address: :internal

    private

    def resource_attrs
      %i[number total shipping_cost tax sale_channel customer_id shipping_address_id billing_address_id]
    end
  end
end
