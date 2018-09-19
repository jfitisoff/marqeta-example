# Very simple factory so I don't trip over validations or wrinkles in the API
# that I don't understand yet.
FactoryBot.define do
  factory :user, class: Hash do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }

    trait :minimal do
      transient do
        first_name { Faker::Name.first_name }
        last_name  { Faker::Name.last_name }
        email { Faker::Internet.email }
      end
    end

    skip_create
    initialize_with { attributes }
  end
end
