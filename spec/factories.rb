FactoryBot.define do
  sequence(:email)    { |i| "email_#{i}@example.com" }
  sequence(:username) { |i| "user_#{i}" }

  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    username
    email

    factory :user_with_points do
      transient do
        points 1
        total  10
      end

      after :create do |user, evaluator|
        points    = evaluator.points
        value_per = evaluator.total/evaluator.points

        create_list(:point, points, :user => user, :value => value_per)
      end
    end
  end

  factory :point do
    user
    value 0
    label { Faker::Lorem.word }
  end
end
