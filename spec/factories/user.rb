FactoryBot.define do
  factory :user do
    trait :regular_user do
      role { :regular_user }
    end

    trait :user_manager do
      role { :user_manager }
    end

    trait :admin do
      role { :admin }
    end
  end
end
