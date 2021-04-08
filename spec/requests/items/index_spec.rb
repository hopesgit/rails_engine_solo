require 'rails_helper'

describe 'When I send a request to "/api/v1/items"' do
  describe 'with no params/body' do
    before :each do
      @merchant = create(:merchant)
      @items = []
      50.times do
        @items << create(:item, merchant_id: @merchant.id)
      end
    end

    it 'I get a successful response' do
      get '/api/v1/items'

      expect(response).to have_http_status(200)
    end

    it 'I get 20 items by default' do
      get('/api/v1/items')
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response.all? {|record| record[:type] == "item" }).to be true
      expect(parsed_response.count).to eq(20)
    end

    it 'gets the specified page' do
      get('/api/v1/items')
      parsed_response_1 = JSON.parse(response.body, symbolize_names: true)[:data]

      get '/api/v1/items', params: {
        page: 2,
        }

      parsed_response_2 = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response_2).to_not eq(parsed_response_1)
    end

    it 'gets the specified amount of items' do
      get('/api/v1/items')
      parsed_response_1 = JSON.parse(response.body, symbolize_names: true)[:data]

      get '/api/v1/items', params: {
        per_page: 25,
        }

      parsed_response_2 = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response_1.count).to eq(20)
      expect(parsed_response_2.count).to eq(25)
      expect(parsed_response_2).to_not eq(parsed_response_1)
    end

    it 'accepts per_page and page' do
      get '/api/v1/items', params: {
        per_page: 15,
        page: 1
      }

      parsed_response_1 = JSON.parse(response.body, symbolize_names: true)[:data]

      get '/api/v1/items', params: {
        per_page: 15,
        page: 2
      }

      parsed_response_2 = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response_1.count).to eq(15)
      expect(parsed_response_2.count).to eq(15)
      expect(parsed_response_1).to_not eq(parsed_response_2)
    end

    # sad path
    # test if input is a string that can't be converted to integer
    # test if page is entered as 0 or less
  end
end
