require 'rails_helper'

describe 'PurchasesController', :type => :request do
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

  context 'filters' do
    context 'by range' do
      let(:start_date) { Date.today - 1.month }
      let(:end_date) { Date.today + 1.month }
      let!(:purchase1) { create(:purchase, created_at: start_date) }
      let!(:purchase2) { create(:purchase, created_at: end_date) }

      it 'retrieves purchases within the range' do
        get "/purchases?start_date=#{start_date}&end_date=#{end_date}"
        expect(response).to be_success
        expect(response.body).to include(purchase1.total.to_s)
        expect(response.body).to include(purchase2.total.to_s)
      end
    end

    context 'by customer id' do
      let(:customer) { create(:customer) }
      let!(:purchase1) { create(:purchase, customer: customer) }
      let!(:purchase2) { create(:purchase, customer: customer) }

      it 'retrieves purchases by customer id' do
        get "/purchases?customer_id=#{customer.id}"
        expect(response).to be_success
        expect(response.body).to include(purchase1.total.to_s)
        expect(response.body).to include(purchase2.total.to_s)
      end
    end

    context 'by category id' do
      let(:product) { create(:product, :with_category) }
      let(:category) { product.categories.first }
      let!(:purchase1) { create(:purchase, product: product) }
      let!(:purchase2) { create(:purchase, product: product) }

      it 'retrieves purchases by category id' do
        get "/purchases?category_id=#{category.id}"
        expect(response).to be_success
        expect(response.body).to include(purchase1.total.to_s)
        expect(response.body).to include(purchase2.total.to_s)
      end
    end

    context 'combined filters' do
      let(:customer) { create(:customer) }
      let(:product) { create(:product, :with_category) }
      let(:category) { product.categories.first }
      let(:start_date) { Date.today - 1.month }
      let(:end_date) { Date.today + 1.month }
      let!(:purchase1) { create(:purchase, customer: customer, product: product, created_at: start_date) }
      let!(:purchase2) { create(:purchase, customer: customer, product: product, created_at: end_date) }

      it 'retrieves purchases by category id' do
        get "/purchases?category_id=#{category.id}&customer_id=#{customer.id}&start_date=#{start_date}&end_date=#{end_date}"
        expect(response).to be_success
        expect(response.body).to include(purchase1.total.to_s)
        expect(response.body).to include(purchase2.total.to_s)
      end
    end
  end
end
