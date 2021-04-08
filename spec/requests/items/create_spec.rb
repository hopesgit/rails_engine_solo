require 'rails_helper'

describe "when I send a post request to '/api/v1/items'" do
  describe 'with a JSON body consisting of the attributes needed' do
    before :each do
      @merchant = create(:merchant)
    end

    it 'creates an item' do
      test_data = {
        name: "Dog bones",
        description: "Chewy and nutritous!",
        unit_price: 25.00,
        merchant_id: @merchant.id
      }

      post '/api/v1/items', params: { item: test_data}
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to have_http_status(:success)
      expect(parsed_response[:id]).to_not be nil
      expect(parsed_response[:attributes][:name]).to_not be nil
      expect(parsed_response[:attributes][:name]).to eq("Dog bones")
      expect(parsed_response[:attributes][:description]).to_not be nil
      expect(parsed_response[:attributes][:description]).to eq("Chewy and nutritous!")
      expect(parsed_response[:attributes][:merchant_id]).to_not be nil
      expect(parsed_response[:attributes][:merchant_id]).to eq(@merchant.id)
      expect(parsed_response[:attributes][:unit_price]).to_not be nil
      expect(parsed_response[:attributes][:unit_price]).to eq(25.00)
    end
  end
end
