require 'rails_helper'
describe ItemsFacade do
  describe 'class methods' do
    describe 'index' do
      before :each do
        @merchant_1 = create(:merchant)
        @items_1 = []
        20.times do
          @items_1 << create(:item, merchant_id: @merchant_1.id)
        end

        @merchant_2 = create(:merchant)
        @items_2 = []
        20.times do
          @items_2 << create(:item, merchant_id: @merchant_2.id)
        end
      end
      # happy_path

      it 'with no given params' do
        expect(ItemsFacade.index).to be_an Array
        expect(ItemsFacade.index.count).to eq(20)
        expect(ItemsFacade.index.all? {|record| record.class == Item }).to be true
        expect(ItemsFacade.index[19]).to eq(@items_1.last)
      end

      it 'can paginate merchant records' do
        test = ItemsFacade.index(20, 2)
        expect(test).to eq(@items_2)
      end

      it 'allows more records to be sent per page' do
        test = ItemsFacade.index(30)
        expect(test.count).to eq(30)
        expect(test).to eq(@items_1 + @items_2.first(10))
      end

      it 'allows per_page and page to be specified' do
        items = Item.all[15..29]

        test = ItemsFacade.index(15, 2)
        expect(test).to eq(items)
        expect(test.count).to eq(15)
        expect(test[0]).to_not eq(Item.first)
      end

      # sad path
      it 'hopefully doesn\'t break when a page has no records' do
        test = ItemsFacade.index(40, 2)

        expect(test).to eq([])
      end

      it 'only reports the number of records available' do
        items = Item.all
        test = ItemsFacade.index(50)

        expect(test).to eq(items)
        expect(test.count).to eq(40)
      end
    end

    describe '.show' do
      it 'fetches an item' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)
        test = ItemsFacade.show(item.id)

        expect(test).to eq(item)
      end
    end

    describe '.find_items' do
      xit 'finds the merchant\'s items' do
        merchant = create(:merchant)
        5.times do
          create(:item, merchant_id: merchant.id)
        end

        test = ItemsFacade.find_items(merchant.id)

        expect(test).to eq(merchant.items)
        expect(test.count).to eq(5)
        expect(test.all? {|merchant_item| merchant_item.merchant_id == merchant.id}).to be true

        merchant2 = create(:merchant)
        5.times do
          create(:item, merchant_id: merchant2.id)
        end

        test2 = ItemsFacade.find_items(merchant2.id)

        expect(test2).to_not eq(test)
        expect(test2.count).to_not eq(10)
      end
    end
  end
end
