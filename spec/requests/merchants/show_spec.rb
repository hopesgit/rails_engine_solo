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

    expect(parsed_response[:attributes][:name]).to eq(@merchant.name)
  end

  # sad path
  it 'can\'t return data for a merchant that doesn\'t exist' do
    get '/api/v1/merchants/1000000'
    rescue ActiveRecord::RecordNotFound

    expect(response).to be nil
  end
end
