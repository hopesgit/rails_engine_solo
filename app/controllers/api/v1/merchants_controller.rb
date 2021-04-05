class Api::V1::MerchantsController < ApplicationController
  def index
    all = if params[:page] && params[:per_page]
            MerchantsFacade.index(params[:per_page], params[:page])
          elsif params[:page]
            MerchantsFacade.index(20, params[:page])
          elsif params[:per_page]
            MerchantsFacade.index(params[:per_page])
          else
            MerchantsFacade.index
          end

    render json: MerchantsSerializer.new(all).serialized_json
  end
end
