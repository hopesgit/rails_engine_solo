require 'rails_helper'
describe MerchantsFacade do
  describe 'class methods' do
    describe 'index' do
      before :each do
        40.times do
          create(:merchant)
        end
      end

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
    end
  end
end
