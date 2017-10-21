FactoryGirl.define do
  factory :package do
    sequence(:name) { |n| "Package - #{n} -" }
    version '0.1.1'
    published_at { 1.day.ago }
    sequence(:title) { |n| "Title - #{n} -" }
    description { "description for #{name}" }

    after(:create) do |f|
      create_list(:package_author, 2, package: f)
      create_list(:package_maintainer, 2, package: f)
    end
  end
end
