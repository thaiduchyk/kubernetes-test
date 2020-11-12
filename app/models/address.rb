# frozen_string_literal: true

class Address < PrimaryBase
  validates :city, presence: true, allow_blank: true
  validates :country, presence: true
  validates :line_1, presence: true

  #belongs_to :country
  #belongs_to :country_zone
end
