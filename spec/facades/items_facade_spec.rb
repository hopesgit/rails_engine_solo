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
        items = @items_1 + @items_2
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

    describe '.new_item' do
      it 'creates an item' do
        merchant = create(:merchant)
        info = {
          name: "Baby soap",
          description: "Soap for babies",
          unit_price: 6.67,
          merchant_id: merchant.id
        }

        test = ItemsFacade.new_item(info)
        expect(test.name).to eq(info[:name])
        expect(test.description).to eq(info[:description])
        expect(test.unit_price).to eq(info[:unit_price])
        expect(test.merchant_id).to eq(info[:merchant_id])
      end
    end

    describe '.update' do
      it 'should update the indicated item' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

        data = {
          name: "Hello World!",
          description: "The first thing you need to know!"
        }

        test = ItemsFacade.update(item.id, data)

        expect(test.name).to_not eq(item.name)
        expect(test.description).to_not eq(item.description)
        expect(test.id).to eq(item.id)
        expect(test.merchant_id).to eq(item.merchant_id)
        expect(test.unit_price).to eq(item.unit_price)
      end
    end

    describe '.destroy' do
      it 'destroys the item' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)
        item_id = item.id

        expect(Item.find(item_id)).to eq(item)
        ItemsFacade.destroy(item_id)
        expect{ Item.find(item_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe '.find_merchant' do
      it 'finds the item\'s seller' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

        test = ItemsFacade.find_merchant(item.id)

        expect(test).to eq(merchant)
      end
    end
  end
end
