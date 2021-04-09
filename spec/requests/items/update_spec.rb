require 'rails_helper'

describe 'When I sent a patch request to "/api/v1/items/:id"' do
  describe 'with a JSON body' do
    it 'sends a successful response' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      data = { description: "Hits the big leagues now!" }
      expect(item.description).to_not eq(data[:description])

      patch "/api/v1/items/#{item.id}", params: { item: data }

      item.reload
      expect(item.description).to eq(data[:description])
    end
  end
end
