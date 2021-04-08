class Api::V1::ItemsController < ApplicationController
  def index
    all = if params[:page] && params[:per_page]
            ItemsFacade.index(params[:per_page].to_i, params[:page].to_i)
          elsif params[:page]
            ItemsFacade.index(20, params[:page].to_i)
          elsif params[:per_page]
            ItemsFacade.index(params[:per_page].to_i)
          else
            ItemsFacade.index
          end

    render json: ItemSerializer.new(all).serialized_json
  end
end
