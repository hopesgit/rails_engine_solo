class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(MerchantsFacade.find_items(params[:id].to_i)).serialized_json
  end
end
