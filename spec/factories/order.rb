FactoryBot.define do
  factory :order do
    sequence(:number)
    status  { Order.statuses[:novel] }
    sale_channel { Order.sale_channels[:website] }
    customer

    after(:build) do |order|
    	order.shipping_address = order.customer.shipping_address
    	order.billing_address = order.customer.billing_address
    end
  end
end
