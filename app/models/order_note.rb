# frozen_string_literal: true

class OrderNote < PrimaryBase
  validates :text, presence: true

  belongs_to :order
end
