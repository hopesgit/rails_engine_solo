class Api::V1::MerchantsController < ApplicationController
  def index
    all = if params[:page] && params[:per_page]
            MerchantsFacade.index(params[:per_page].to_i, params[:page].to_i)
          elsif params[:page]
            MerchantsFacade.index(20, params[:page].to_i)
          elsif params[:per_page]
            MerchantsFacade.index(params[:per_page].to_i)
          else
            MerchantsFacade.index
          end

    render json: MerchantSerializer.new(all).serialized_json
  end

  def show
    render json: MerchantSerializer.new(MerchantsFacade.show(params[:id])).serialized_json
  end
end
