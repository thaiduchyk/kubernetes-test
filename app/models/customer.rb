# frozen_string_literal: true

class Customer < PrimaryBase
  include Defaultable

  DEFAULT_VALUES = {
    active: true
  }.freeze

  validates :fullname, presence: true
  validates :email, presence: true

  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :billing_address, class_name: 'Address'
end
