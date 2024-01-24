FactoryGirl.define do
  factory :customer do
    sequence(:first_name) { |n| "customer#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    sequence(:id_number) { |n| "321#{n}" }
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

  factory :admin do
    sequence(:email) { |n| "test#{n}@test.com" }
    password "123123"
  end

  factory :photo do
    sequence(:name) { |n| "test#{n}" }
    image "image"
  end

  factory :product do
    sequence(:name) { |n| "mazda#{n}" }
    description "mazda"
    type "car"
    price 400.000
    categories { [FactoryGirl.create(:category)] }

    trait :with_photo do
      after(:create) do |product|
        product.photos << FactoryGirl.create(:photo)
      end
    end

    trait :with_category do
      after(:create) do |product|
        product.categories << FactoryGirl.create(:category)
      end
    end
  end

  factory :purchase do
    customer { FactoryGirl.create(:customer) }
    product { FactoryGirl.create(:product) }
    quantity 3
  end
end
