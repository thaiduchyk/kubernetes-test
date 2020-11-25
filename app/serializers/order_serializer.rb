# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :number, :status, :total, :shipping_cost, :tax, :sale_channel, :created_at

  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :customer
end
