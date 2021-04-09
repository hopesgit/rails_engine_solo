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

  def show
    render json: ItemSerializer.new(ItemsFacade.show(params[:id])).serialized_json
  end

  def create
    render json: ItemSerializer.new(ItemsFacade.new_item(create_params)).serialized_json
  end

  def update
    render json: ItemSerializer.new(ItemsFacade.update(params[:id], update_params)).serialized_json
  end

  def destroy
    render json: ItemSerializer.new(ItemsFacade.destroy(params[:id])).serialized_json
  end

  private

  def create_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def update_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
