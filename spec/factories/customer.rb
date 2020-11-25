FactoryBot.define do
  factory :customer do
    fullname { Faker::Name.name }
    email  { Faker::Internet.email }
    active { true }

    association :shipping_address, factory: :address
    association :billing_address, factory: :address
  end
end
