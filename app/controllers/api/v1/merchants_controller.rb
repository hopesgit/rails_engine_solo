class Api::V1::MerchantsController < ApplicationController
  def index
    @all = if params[:page] && params[:per_page]
            MerchantsFacade.index(params[:per_page], params[:page])
          elsif params[:page]
            MerchantsFacade.index(20, params[:page])
          elsif params[:per_page]
            MerchantsFacade.index(params[:per_page])
          else
            MerchantsFacade.index
          end
    render json: @all
    # page = params[:page] if !params[:page].nil?
    # per_page = params[:perPage] if !params[:perPage].nil?
    # render json: MerchantsFacade.index(perPage, page).to_json
  end
end
