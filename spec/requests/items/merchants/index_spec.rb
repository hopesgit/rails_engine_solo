require 'rails_helper'

describe "When I send a request to '/api/v1/items/:id/merchant'" do
  describe "I get information on the merchant who sells the item" do
    before :each do
      @merchant = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id)
    end
    it 'sends a successful response' do
      get "/api/v1/items/#{@item.id}/merchant"

      expect(response).to have_http_status(:success)
    end

    it 'fetches merchant data for the item' do
      get "/api/v1/items/#{@item.id}/merchant"

      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][0]
      expect(parsed_response[:id]).to eq(@item.merchant_id.to_s)
      expect(parsed_response[:attributes][:name]).to eq(@merchant.name)
    end
  end
end
