# frozen_string_literal: true

class Part < PrimaryBase
  include Defaultable

  DEFAULT_VALUES = {
    direct_shipment: false,
    placeholder: false
  }.freeze

  validates :name, presence: true, uniqueness: true
end
