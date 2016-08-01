FactoryGirl.define do
  factory :user, class: '::User' do
    name { Faker::Internet.user_name }
    email { Faker::Internet.email }
  end
end
