require 'rails_helper'

describe Purchase, :type => :model do
  context 'callbacks' do
    let(:quantity) { 2 }
    let(:price) { 5.0 }
    let(:purchase) { build(:purchase, :with_product, quantity: quantity, price: price) }

    it 'updates the purchase total' do
      expect(purchase.total).to eq(nil)
      purchase.save
      expect(purchase.total).to eq(10.0)
    end
  end

  context 'scopes' do
    context 'by range' do
      let(:start_date) { Date.today - 1.month }
      let(:end_date) { Date.today + 1.month }
      let(:purchase1) { create(:purchase, created_at: start_date) }
      let(:purchase2) { create(:purchase, created_at: end_date) }

      it 'retrieves purchases within the range' do
        expect(Purchase.range(start_date, end_date)).to include(purchase1, purchase2)
      end

      context 'by customer id' do
        let(:customer) { create(:customer) }
        let(:purchase1) { create(:purchase, customer: customer) }
        let(:purchase2) { create(:purchase, customer: customer) }

        it 'retrieves purchases by customer id' do
          expect(Purchase.by_customer(customer.id)).to include(purchase1, purchase2)
        end
      end

      context 'by category id' do
        let(:product) { create(:product, :with_category) }
        let(:category) { product.categories.first }
        let(:purchase1) { create(:purchase, product: product) }
        let(:purchase2) { create(:purchase, product: product) }

        it 'retrieves purchases by category id' do
          expect(Purchase.by_category(category.id)).to include(purchase1, purchase2)
        end
      end
    end
  end
end
