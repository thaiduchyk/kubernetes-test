# frozen_string_literal: true

module Admin
  class OrdersController < BaseController
    enable_query_filters %w[number status sale_channel]
    enable_expand_fields customer: :internal, shipping_address: :internal, billing_address: :internal

    def index
      render_collection collection
    end

    def show
      render_resource resource
    end
  end
end
