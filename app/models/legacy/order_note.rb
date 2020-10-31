# frozen_string_literal: true

module Legacy
  class OrderNote < LegacyBase
    self.table_name = 'k_INVOICE_NOTE'

    include Importable

    belongs_to :order, class_name: 'Legacy::Order', foreign_key: 'k_INVOICE_ID'

    IMPORT_MAP = {
      ::OrderNote => {
        'direct' => {
          'k_INVOICE_NOTE_DATE' => 'created_at',
          'k_INVOICE_NOTE_TEXT' => 'text',
          'k_INVOICE_NOTE_ID' => 'legacy_id'
        }
      }
    }.freeze

    def import_to_primary
      return if k_INVOICE_NOTE_TEXT.blank? || k_INVOICE_ID.zero?

      perform_import do
        order_note = build_object(::OrderNote)
        order = ::Order.find_by(number: self.order.k_INVOICE_ID)
        order_note.order = order
        order_note.save!
      end
    end
  end
end
