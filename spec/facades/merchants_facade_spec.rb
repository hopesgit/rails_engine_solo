require 'rails_helper'
describe MerchantsFacade do
  describe 'class methods' do
    describe 'index' do
      before :each do
        40.times do
          create(:merchant)
        end
      end
      # happy_path

      it 'with no given params' do
        merchants = Merchant.first(20)

        expect(MerchantsFacade.index).to be_an Array
        expect(MerchantsFacade.index.count).to eq(20)
        expect(MerchantsFacade.index.all? {|record| record.class == Merchant }).to be true
        expect(MerchantsFacade.index[19]).to eq(merchants[19])
      end

      it 'can paginate merchant records' do
        merchants = Merchant.all[20..39]

        test = MerchantsFacade.index(20, 2)
        expect(test).to eq(merchants)
      end

      it 'allows more records to be sent per page' do
        merchants = Merchant.first(30)

        test = MerchantsFacade.index(30)
        expect(test.count).to eq(30)
        expect(test).to eq(merchants)
      end

      it 'allows per_page and page to be specified' do
        merchants = Merchant.all[15..29]

        test = MerchantsFacade.index(15, 2)
        expect(test).to eq(merchants)
        expect(test.count).to eq(15)
        expect(test[0]).to_not eq(Merchant.first)
      end

      # sad path
      it 'hopefully doesn\'t break when a page has no records' do
        test = MerchantsFacade.index(40, 2)

        expect(test).to eq([])
      end

      it 'only reports the number of records available' do
        merchants = Merchant.all
        test = MerchantsFacade.index(50)

        expect(test).to eq(merchants)
        expect(test.count).to eq(40)
      end
    end

    describe '.show' do
      it 'fetches a merchant' do
        merchant = create(:merchant)
        test = MerchantsFacade.show(merchant.id)

        expect(test).to eq(merchant)
      end
    end

    describe '.find_items' do
      it 'finds the merchant\'s items' do
        merchant = create(:merchant)
        5.times do
          create(:item, merchant_id: merchant.id)
        end

        test = MerchantsFacade.find_items(merchant.id)

        expect(test).to eq(merchant.items)
        expect(test.count).to eq(5)
        expect(test.all? {|merchant_item| merchant_item.merchant_id == merchant.id}).to be true

        merchant2 = create(:merchant)
        5.times do
          create(:item, merchant_id: merchant2.id)
        end

        test2 = MerchantsFacade.find_items(merchant2.id)

        expect(test2).to_not eq(test)
        expect(test2.count).to_not eq(10)
      end
    end
  end
end
