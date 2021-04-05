require 'rails_helper'

describe 'When I send a request to "/api/v1/merchants"' do
  describe 'with no params/body' do
    before :each do
      20.times do
        create(:merchant)
      end
    end

    it 'I get a successful response' do
      response = get '/api/v1/merchants'

      expect(response).to have_http_status(200)
    end

    it 'I get 20 merchants by default' do
      response = get '/api/v1/merchants'
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response.all? {|record| record.class == Merchant }).to be_true
      expect(parsed_response.count).to eq(20)
    end
  end
end
