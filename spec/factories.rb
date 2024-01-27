FactoryBot.define do
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
    password { '123123' }
  end

  factory :photo do
    sequence(:name) { |n| "test#{n}" }
    image { 'image' }
  end

  factory :product do
    sequence(:name) { |n| "mazda#{n}" }
    description { 'mazda' }
    type { 'car' }
    price { 400.0  }

    trait :with_photo do
      after(:create) do |product|
        product.photos << FactoryBot.create(:photo)
      end
    end

    trait :with_category do
      after(:create) do |product|
        product.categories << FactoryBot.create(:category)
      end
    end
  end

  factory :purchase do
    customer { FactoryBot.create(:customer) }
    product { FactoryBot.create(:product) }
    quantity { 3 }

    trait :with_product do
      transient do
        price { 10.0 }
      end

      after(:build) do |purchase, e|
        purchase.product = FactoryBot.create(:product, price: e.price)
      end
    end
  end
end
