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
end
