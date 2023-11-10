class SeasonalPricesController < ApplicationController
  before_action :get_lodge_and_room
  
  def new
    @seasonal_price = @room.seasonal_prices.build
  end

  def create
    @seasonal_price = @room.seasonal_prices.build(seasonal_price_params)

    if @seasonal_price.save
      return redirect_to [@lodge, @room], notice: 'Preço de temporada adicionado com sucesso.'
    end

    flash.now[:notice] = 'Não foi possível adicionar preço de temporada.'

    render :new
  end

  private

  def get_lodge_and_room
    @lodge = Lodge.find(params[:lodge_id])
    @room = @lodge.rooms.find_by(id: params[:room_id])
  end

  def seasonal_price_params
    params.require(:seasonal_price).permit(:name, :start_date, :end_date, :price)
  end
end