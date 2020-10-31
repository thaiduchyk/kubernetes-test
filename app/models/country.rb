# frozen_string_literal: true

class Country < PrimaryBase
  validates :name, presence: true, uniqueness: true
  validates :iso_code_2, presence: true, uniqueness: true
  validates :iso_code_3, presence: true, uniqueness: true
end
