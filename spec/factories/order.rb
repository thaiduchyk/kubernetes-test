FactoryBot.define do
  factory :order do
    sequence(:number)
    status  { Order.statuses[:novel] }
    sale_channel { Order.sale_channels[:website] }
  end
end
