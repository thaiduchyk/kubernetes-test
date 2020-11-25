FactoryBot.define do
  factory :address do
    company { Faker::Company.name }
    firstname { Faker::Name.first_name  }
    lastname { Faker::Name.last_name  }
    phone { Faker::PhoneNumber.phone_number }
    line_1 { Faker::Address.street_address }
    postal_code { Faker::Address.zip }
    city { Faker::Address.city }
    country { Faker::Address.country }
  end
end
