# frozen_string_literal: true

module Builders
  class OrderBuilder < BaseBuilder
    private

    def initialize_resource
      Order.new
    end
  end
end
