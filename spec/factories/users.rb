FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { 'aaaa@gmail.com' }
    password { 'yh1111' }
    password_confirmation { 'yh1111' }
    introduction { Faker::Lorem.sentence }
  end
end
