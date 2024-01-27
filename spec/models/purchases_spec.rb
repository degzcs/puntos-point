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
          expect(Purchase.by_customer_id(customer.id)).to include(purchase1, purchase2)
        end
      end

      context 'by category id' do
        let(:product) { create(:product, :with_category) }
        let(:category) { product.categories.first }
        let(:purchase1) { create(:purchase, product: product) }
        let(:purchase2) { create(:purchase, product: product) }

        it 'retrieves purchases by category id' do
          expect(Purchase.by_category_id(category.id)).to include(purchase1, purchase2)
        end

        context 'by granularity' do
          let!(:purchase1) { create(:purchase, created_at: '2024-01-26') }
          let!(:purchase2) { create(:purchase, created_at: '2024-01-26') }
          let!(:purchase3) { create(:purchase, created_at: '2024-01-25') }
          let!(:purchase4) { create(:purchase, created_at: '2024-02-01') }
          let!(:purchase5) { create(:purchase, created_at: '2024-03-01') }
          let!(:purchase6) { create(:purchase, created_at: '2024-03-02') }
          let(:granularity) { '' }

          context 'when granularity is day' do
            let(:granularity) { 'day' }

            context 'when range is 1 day' do
              let(:start_date) { '2024-01-26' }
              let(:end_date) { '2024-01-26' }

              it 'retrieves purchases by granularity' do
                result = Purchase.range(start_date, end_date).by_granularity(granularity)
                first_result = result.first.attributes
                expect(result.to_a.count).to eq(1)
                expect(first_result['purchase_granularity']).to eq '2024-01-26 00:00:00'
                expect(first_result['purchase_count']).to eq(2.to_s)
              end
            end
          end

          context 'when granularity is hour' do
            before :each do
              purchase2.created_at = '2024-01-26 05:00:00'
              purchase2.save
            end

            let(:granularity) { 'hour' }

            context 'when range is 1 day' do
              let(:start_date) { '2024-01-26' }
              let(:end_date) { '2024-01-26' }

              it 'retrieves purchases by granularity' do
                result = Purchase.range(start_date, end_date).by_granularity(granularity)
                expected_result = [
                  {"purchase_count"=>"1", "purchase_granularity"=>"2024-01-26 00:00:00"},
                  {"purchase_count"=>"1", "purchase_granularity"=>"2024-01-26 05:00:00"}
                ]
                expect(result.to_a.count).to eq(2)
                expect(result.map(&:attributes)).to eq(expected_result)
              end
            end
          end

          context 'when granularity is week' do
            let(:granularity) { 'week' }

            context 'when range is 1 week' do
              let(:start_date) { '2024-01-20' }
              let(:end_date) { '2024-01-26' }

              it 'retrieves purchases by granularity' do
                result = Purchase.range(start_date, end_date).by_granularity(granularity)
                first_result = result.first.attributes
                expect(result.to_a.count).to eq(1)
                expect(first_result['purchase_granularity']).to eq '2024-01-22 00:00:00'
                expect(first_result['purchase_count']).to eq(3.to_s)
              end
            end

            context 'when granularity is month' do
              let(:granularity) { 'month' }

              context 'when range is 2 month' do
                let(:start_date) { '2024-01-01' }
                let(:end_date) { '2024-02-31' }

                it 'retrieves purchases by granularity' do
                  result = Purchase.range(start_date, end_date).by_granularity(granularity)
                  expected_result = [
                    {"purchase_count"=>"3", "purchase_granularity"=>"2024-01-01 00:00:00"},
                    {"purchase_count"=>"1", "purchase_granularity"=>"2024-02-01 00:00:00"},
                    {"purchase_count"=>"2", "purchase_granularity"=>"2024-03-01 00:00:00"}
                  ]
                  expect(result.to_a.count).to eq(3)
                  expect(result.map(&:attributes)).to eq(expected_result)
                end
              end
            end

            context 'when granularity is year' do
              let(:granularity) { 'year' }

              context 'when range is 2 year' do
                let(:start_date) { '2024-01-01' }
                let(:end_date) { '2025-01-01' }

                it 'retrieves purchases by granularity' do
                  result = Purchase.range(start_date, end_date).by_granularity(granularity)
                  expected_result = [
                    {"purchase_count"=>"6", "purchase_granularity"=>"2024-01-01 00:00:00"},
                  ]
                  expect(result.to_a.count).to eq(1)
                  expect(result.map(&:attributes)).to eq(expected_result)
                end
              end
            end
          end
        end
      end
    end
  end
end
