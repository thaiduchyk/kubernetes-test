# frozen_string_literal: true

class AddressSerializer < ActiveModel::Serializer
  attributes :id, :company, :firstname, :lastname, :phone, :line_1, :line_2, :postal_code, :city,
             :country, :country_zone
end
