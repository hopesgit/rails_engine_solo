require 'rails_helper'

describe 'When I send a request to "/api/v1/merchants"' do
  describe 'with no params/body' do
    before :each do
      40.times do
        create(:merchant)
      end
      @merchants = Merchant.last(40)
    end

    it 'I get a successful response' do
      get '/api/v1/merchants'

      expect(response).to have_http_status(200)
    end

    it 'I get 20 merchants by default' do
      get('/api/v1/merchants')
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response.all? {|record| record[:type] == "merchant" }).to be true
      expect(parsed_response.count).to eq(20)
    end

    it 'gets the specified page' do
      get('/api/v1/merchants')
      parsed_response_1 = JSON.parse(response.body, symbolize_names: true)[:data]

      get '/api/v1/merchants', params: {
        page: 2,
        }

      parsed_response_2 = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response_2).to_not eq(parsed_response_1)
    end

    it 'gets the specified amount of merchants' do
      get('/api/v1/merchants')
      parsed_response_1 = JSON.parse(response.body, symbolize_names: true)[:data]

      get '/api/v1/merchants', params: {
        per_page: 25,
        }

      parsed_response_2 = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response_1.count).to eq(20)
      expect(parsed_response_2.count).to eq(25)
      expect(parsed_response_2).to_not eq(parsed_response_1)
    end

    it 'accepts per_page and page' do
      get '/api/v1/merchants', params: {
        per_page: 15,
        page: 1
      }

      parsed_response_1 = JSON.parse(response.body, symbolize_names: true)[:data]

      get '/api/v1/merchants', params: {
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
