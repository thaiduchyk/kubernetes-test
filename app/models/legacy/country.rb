# frozen_string_literal: true

module Legacy
  class Country < LegacyBase
    self.table_name = 'gc_countries'

    def import_to_primary
      attr = attributes.except('id', 'sequence', 'tax')
      attr[:enabled] = attr.delete('status')
      ::Country.create(attr)
    end
  end
end
