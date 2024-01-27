require 'rails_helper'

describe Product, :type => :model do
  context '#scopes' do
    let!(:product1) { create(:product, :with_category) }
    let(:category1) { product1.categories.first }
    let!(:product2) { create(:product, categories: [category1]) }

    let!(:product3) { create(:product, :with_category) }
    let(:category2) { product3.categories.first }
    let!(:product4) { create(:product, categories: [category2]) }

    let!(:purchase1) { create_list(:purchase, 3, product: product1) }
    let!(:purchase2) { create_list(:purchase, 5, product: product2) }
    let!(:purchase3) { create_list(:purchase, 2, product: product4) }

    it 'retrieves the top products by each category' do
      expect(Product.top_products_by_category).to include(product2, product4)
    end

    it 'retrieves the top 1 best sellerproducts by category' do
      expect(Product.top_best_sellers_by_category(1)).to include(product2, product4)
    end
  end
end
