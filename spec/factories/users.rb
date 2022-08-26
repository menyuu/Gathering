FactoryBot.define do
  factory :end_user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }

    after(:build) do |user|
      user.icon.attach(io: File.open('spec/images/user.png'), filename: 'user.png', content_type: 'application/xlsx')
    end
  end
end