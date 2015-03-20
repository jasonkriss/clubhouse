FactoryGirl.define do
  factory :clubhouse_invitation, class: Clubhouse::Invitation do
    sequence(:email) { |n| "invitation-#{n}@example.com" }

    trait :with_associations do
      association :organization, factory: :clubhouse_organization
    end
  end
end
