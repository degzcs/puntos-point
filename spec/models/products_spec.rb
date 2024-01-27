require 'rails_helper'

describe Product, type: :model do
  before :each do
    Rails.cache.clear
  end

  context '#scopes' do
    let!(:product1) { create(:product, :with_category) }
    let!(:category1) { product1.categories.first }
    let!(:product2) { create(:product, categories: [category1]) }

    let!(:product3) { create(:product, :with_category) }
    let!(:category2) { product3.categories.first }
    let!(:product4) { create(:product, categories: [category2]) }

    let!(:purchase1) { create_list(:purchase, 3, product: product1) }
    let!(:purchase2) { create_list(:purchase, 5, product: product2) }
    let!(:purchase3) { create_list(:purchase, 2, product: product4) }

    context 'top products by category' do
      it 'retrieves the top products by each category' do
        expect(described_class.top_products_by_category).to include(product2, product4)
        expect(described_class.top_products_by_category).not_to include(product1, product3)
      end
    end

    context 'best sellers' do
      before :each do
        create_list(:purchase, 13, product: product1)
      end

      it 'retrieves the top 1 best sellerproducts by category' do
        result = described_class.top_best_sellers_by_category(1)
        expect(result).to include(product1, product4)
        expect(result).not_to include(product2, product3)
      end

      it 'retrieves the top 2 best sellerproducts by category' do
        result2 = described_class.top_best_sellers_by_category(2)
        expect(result2).to include(product1, product2, product4)
        expect(result2).not_to include(product3)
      end
    end
  end
end
