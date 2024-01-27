require 'rails_helper'

describe 'ProductsController', :type => :request do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:product1) { create(:product, :with_category) }
  let(:category1) { product1.categories.first }
  let!(:product2) { create(:product, categories: [category1]) }

  let!(:product3) { create(:product, :with_category) }
  let(:category2) { product3.categories.first }
  let!(:product4) { create(:product, categories: [category2]) }

  let!(:purchase1) { create_list(:purchase, 3, product: product1) }
  let!(:purchase2) { create_list(:purchase, 5, product: product2) }
  let!(:purchase3) { create_list(:purchase, 2, product: product4) }



  it 'retrieves the top products by category' do
    get "/products/top_products_by_category"
    expect(response).to be_success
    expect(response.body).to include(product1.name)
  end
end
