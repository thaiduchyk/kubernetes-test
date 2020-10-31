# frozen_string_literal: true

module Legacy
  class Order < LegacyBase
    self.table_name = 'k_INVOICE'

    include Importable

    belongs_to :status, class_name: 'Legacy::OrderStatus', foreign_key: 'k_INVOICE_STATUS_ID'

    IMPORT_MAP = {
      Address => {
        'direct' => {
          'k_INVOICE_ADD1' => 'line_1',
          'k_INVOICE_ADD2' => 'line_2',
          'k_INVOICE_CITY' => 'city',
          'k_INVOICE_STATE' => 'country_zone',
          'k_INVOICE_COUNTRY' => 'country',
          'k_INVOICE_PHONE' => 'phone',
          'k_INVOICE_ZIP' => 'postal_code'
        },
        'custom' => {
          'k_INVOICE_NAME' => :process_invoice_name
        }
      },
      Customer => {
        'direct' => {
          'k_INVOICE_NAME' => 'fullname',
          'k_INVOICE_EMAIL' => 'email'
        }
      },
      ::Order => {
        'direct' => {
          'k_INVOICE_ID' => 'number',
          'k_INVOICE_DATE' => 'created_at'
        },
        'custom' => {
          'k_INVOICE_STATUS_ID' => :process_invoice_status
        }
      }
    }.freeze

    def import_to_primary
      perform_import do
        address = find_or_create_address
        customer = find_or_create_customer(address)

        order = build_object(::Order)
        order.customer = customer
        order.billing_address = address
        order.shipping_address = address
        order.sale_channel = 'website'
        order.save!
      end
    end

    def find_or_create_address
      condition = import_map[Address]['direct'].each_with_object({}) do |(legacy_attr, new_attr), result|
        result[new_attr] = attributes[legacy_attr]
      end
      existing_address = Address.find_by(condition)
      return existing_address if existing_address

      address = build_object(Address)
      address.save!
      address
    end

    def find_or_create_customer(address)
      existing_customer = Customer.find_by(fullname: attributes['k_INVOICE_NAME'])
      return existing_customer if existing_customer

      customer = build_object(Customer)
      customer.shipping_address = address
      customer.billing_address = address
      customer.save!
      customer
    end

    def process_invoice_name(attrs)
      full_name = attrs.delete('k_INVOICE_NAME')
      splitted_name = full_name.split(' ')
      if splitted_name.size == 1
        attrs['firstname'] = splitted_name.first
      else
        attrs['lastname'] = splitted_name.pop
        attrs['firstname'] = splitted_name.join(' ')
      end
    end

    def process_invoice_status(attrs)
      attrs.delete('k_INVOICE_STATUS_ID')
      attrs['status'] = status.k_INVOICE_STATUS_NAME
    end
  end
end
