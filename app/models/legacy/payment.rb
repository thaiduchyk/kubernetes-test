# frozen_string_literal: true

module Legacy
  class Payment < LegacyBase
    self.table_name = 'k_TRANSACTION'

    include Importable

    belongs_to :order, class_name: 'Legacy::Order', foreign_key: 'k_INVOICE_ID'

    IMPORT_MAP = {
      ::Payment => {
        'direct' => {
          'k_TXN_AMOUNT' => 'amount',
          'k_TXN_EPN_RESP' => 'processor_response',
          'k_TXNREFID' => 'transaction_id',
          'k_TXN_ID' => 'legacy_id'
        }
      }
    }.freeze

    # we need to import legacy transactions with specific type (Sale ?)
    def import_to_primary
      perform_import do
        payment = build_object(::Payment)
        payment.payment_type = 'card'
        order = ::Order.find_by(number: self.order.k_INVOICE_ID)
        payment.order = order
        payment.save!
      end
    end
  end
end
