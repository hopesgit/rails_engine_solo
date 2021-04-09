require 'rails_helper'

describe 'When I send a get request to "/api/v1/merchants/:id"' do
  before :each do
    @merchant = create(:merchant)
    @item = create(:item, merchant_id: @merchant.id)
  end

  it 'makes a successful request' do
    get "/api/v1/items/#{@item.id}"

    expect(response).to have_http_status(:success)
  end

  it 'returns data for the requested merchant' do
    get "/api/v1/items/#{@item.id}"

    parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(parsed_response[:attributes][:name]).to eq(@item.name)
    expect(parsed_response[:attributes][:description]).to eq(@item.description)
    expect(parsed_response[:attributes][:unit_price]).to eq(@item.unit_price)
    expect(parsed_response[:attributes][:merchant_id]).to eq(@merchant.id)
  end

  # sad path
  it 'can\'t return data for an item that doesn\'t exist' do
    get '/api/v1/items/1000000'
    rescue ActiveRecord::RecordNotFound

    expect(response).to be nil
  end
end
