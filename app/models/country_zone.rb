# frozen_string_literal: true

class CountryZone < PrimaryBase
  validates :name, presence: true
  validates_uniqueness_of :code, scope: :country_id, allow_blank: true

  belongs_to :country
end
