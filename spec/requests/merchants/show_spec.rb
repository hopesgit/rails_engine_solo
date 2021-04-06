require 'rails_helper'

describe 'When I send a get request to "/api/v1/merchants/:id"' do
  before :each do
    @merchant = create(:merchant)
  end

  it 'makes a successful request' do
    get "/api/v1/merchants/#{@merchant.id}"

    expect(response).to have_http_status(:success)
  end

  it 'returns data for the requested merchant' do
    get "/api/v1/merchants/#{@merchant.id}"

    parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed_response[:name]).to eq(@merchant.name)
  end
end
