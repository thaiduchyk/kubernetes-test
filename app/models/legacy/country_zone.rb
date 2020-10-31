# frozen_string_literal: true

module Legacy
  class CountryZone < LegacyBase
    self.table_name = 'gc_country_zones'

    belongs_to :country, class_name: 'Legacy::Country'

    def import_to_primary
      attr = attributes.except('id', 'tax', 'country_id')
      attr[:enabled] = attr.delete('status')
      attr[:country_id] = ::Country.find_by(name: country.name).id
      cz = ::CountryZone.new(attr)
      byebug unless cz.save
    end
  end
end
