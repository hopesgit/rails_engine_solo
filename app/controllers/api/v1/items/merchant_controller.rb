class Api::V1::Items::MerchantController < ApplicationRecord
  def index
    render json: MerchantSerializer.new(ItemsFacade.find_merchant(params[:id])).serialized_json
  end
end
