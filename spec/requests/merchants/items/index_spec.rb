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
    end
  end
end
