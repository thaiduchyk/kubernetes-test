# frozen_string_literal: true

class Utils
  BOOLEAN_STRINGS = { 'true' => %w[t true y yes on 1], 'false' => %w[f false n no off 0] }.freeze

  class << self
    def parse_integer(str)
      Integer(str)
    end

    def parse_boolean(str)
      return str if [true, false].include?(str)

      str = str.downcase
      if Utils::BOOLEAN_STRINGS['true'].include?(str)
        true
      elsif Utils::BOOLEAN_STRINGS['false'].include?(str)
        false
      else
        raise ArgumentError.new("Invalid value for Boolean: #{str}.")
      end
    end
  end
end
