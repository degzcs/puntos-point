require 'rails_helper'

describe 'Products', :type => :request do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:product) { FactoryGirl.create(:product, :with_category) }
  let(:category) { product.categories.first }


  it 'retrieves the top products by category' do
    get "/categories/#{category.id}/products/top"
    expect(response).to be_success
    expect(response.body).to include(product.name)
  end
end
