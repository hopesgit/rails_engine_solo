require 'rails_helper'

describe "When I send a request to '/api/v1/merchant/:id/items'" do
  describe "I get the items that belong to a particular merchant" do
    describe "and the items' details" do
      before :each do
        @merchant = create(:merchant)
        5.times do
          create(:item, merchant_id: @merchant.id)
        end
      end

      it 'sends a successful request' do
        get "/api/v1/merchants/#{@merchant.id}/items"

        expect(response).to have_http_status(:success)
      end

      it 'returns a merchant item and its dependent items' do
        get "/api/v1/merchants/#{@merchant.id}/items"
        parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]
        test = [{
            id: @merchant.items.first.id.to_s,
            type: "item",
            attributes: {
              name: @merchant.items.first.name,
              description: @merchant.items.first.description,
              unit_price: @merchant.items.first.unit_price,
              merchant_id: @merchant.id
            }},
            {
            id: @merchant.items[1].id.to_s,
            type: "item",
            attributes: {
              name: @merchant.items[1].name,
              description: @merchant.items[1].description,
              unit_price: @merchant.items[1].unit_price,
              merchant_id: @merchant.id
            }},
            {
            id: @merchant.items[2].id.to_s,
            type: "item",
            attributes: {
              name: @merchant.items[2].name,
              description: @merchant.items[2].description,
              unit_price: @merchant.items[2].unit_price,
              merchant_id: @merchant.id
            }},
            {
            id: @merchant.items[3].id.to_s,
            type: "item",
            attributes: {
              name: @merchant.items[3].name,
              description: @merchant.items[3].description,
              unit_price: @merchant.items[3].unit_price,
              merchant_id: @merchant.id
            }},
            {
            id: @merchant.items.last.id.to_s,
            type: "item",
            attributes: {
              name: @merchant.items.last.name,
              description: @merchant.items.last.description,
              unit_price: @merchant.items.last.unit_price,
              merchant_id: @merchant.id
            }}
        ]

        expect(parsed_response).to eq(test)
      end
    end
  end
end
