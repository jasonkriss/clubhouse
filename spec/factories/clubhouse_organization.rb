FactoryGirl.define do
  factory :clubhouse_organization, class: Clubhouse::Organization do
    sequence(:name) { |n| "org-#{n}" }
    email "email@example.com"
  end
end
