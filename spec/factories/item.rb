FactoryBot.define do
  factory :item do
    name { Faker::Food.vegetables }
    description { Faker::Food.description }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
