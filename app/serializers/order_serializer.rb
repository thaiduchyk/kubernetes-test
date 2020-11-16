# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :number, :status, :total, :shipping_cost, :tax, :sale_channel
end
