require 'rails_helper'
describe MerchantsFacade do
  describe 'class methods' do
    it 'index' do
      20.times do
        create(:merchant)
      end

      merchants = Merchant.all

      expect(MerchantsFacade.index).to be_an Array
      expect(MerchantsFacade.index.count).to eq(20)
      expect(MerchantsFacade.index.all? {|record| record.class == Merchant }).to be true
      expect(MerchantsFacade.index[19]).to eq(merchants[19])
    end
  end
end
