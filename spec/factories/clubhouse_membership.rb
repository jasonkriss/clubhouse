FactoryGirl.define do
  factory :clubhouse_membership, class: Clubhouse::Membership do

    trait :with_associations do
      association :member, factory: :user
      association :organization, factory: :clubhouse_organization
    end
  end
end
