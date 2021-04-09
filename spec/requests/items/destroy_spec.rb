require 'rails_helper'

describe "When I send a delete request to '/api/v1/items/:id'" do
  describe 'it will destroy that record' do
    it 'does the thing' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      item_id = item.id

      delete "/api/v1/items/#{item.id}"
      expect{ Item.find(item_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
