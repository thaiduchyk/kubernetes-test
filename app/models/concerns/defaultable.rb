# frozen_string_literal: true

module Defaultable
  extend ActiveSupport::Concern

  included do
    after_initialize :set_default_values
  end

  def set_default_values
    default_values.each do |attr, value|
      send("#{attr}=", value) if send(attr).nil?
    end
  end

  def default_values
    self.class::DEFAULT_VALUES
  end
end
