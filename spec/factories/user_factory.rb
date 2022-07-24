# This will guess the User class
FactoryBot.define do
    factory :user do

      factory :user_user do
        email { "john.user@doe.com" }
        password  { "password" }
        confirmed_at { Time.now }
        role {'user'}
      end

      factory :user_manager do
        email { "john.manager@doe.com" }
        password  { "password" }
        confirmed_at { Time.now }
        role {'manager'}
      end

      factory :user_admin do
        email { "john.admin@doe.com" }
        password  { "password" }
        confirmed_at { Time.now }
        role {'admin'}
      end

    end
end