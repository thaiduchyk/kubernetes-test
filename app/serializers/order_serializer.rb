# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :number, :status, :total, :shipping_cost, :tax, :sale_channel

  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :customer
end
