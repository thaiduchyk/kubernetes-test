# frozen_string_literal: true

class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :email, :active, :created_at

  belongs_to :shipping_address
  belongs_to :billing_address
end
