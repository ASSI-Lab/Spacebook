# This will guess the User class
FactoryBot.define do
    factory :user do

      factory :user_user do
        email { "test.user@gmail.com" }
        password  { "password" }
        confirmed_at { Time.now }
        role {'user'}
      end

      factory :user_manager do
        email { "test.manager@gmail.com" }
        password  { "password" }
        confirmed_at { Time.now }
        role {'manager'}
      end

      factory :user_admin do
        email { "test.admin@gmail.com" }
        password  { "password" }
        confirmed_at { Time.now }
        role {'admin'}
      end

    end
end