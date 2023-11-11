class SeasonalPricesController < ApplicationController
  before_action :get_lodge_and_room
  before_action :get_seasonal_price, only: [:edit, :update]
  before_action :authenticate_user!
  
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

  def edit
    @seasonal_price = @room.seasonal_prices.find(params[:id])
  end

  def update
    if @seasonal_price.update(seasonal_price_params)
      return redirect_to lodge_room_path(@lodge, @room), notice: 'Preço de temporada editado com sucesso.'
    end

    flash.now[:notice] = ''
    render 'edit'
  end

  def show
    @seasonal_prices = @room.seasonal_prices
  end

  private

  def get_seasonal_price
    @seasonal_price = @room.seasonal_prices.find(params[:id])
  end

  def get_lodge_and_room
    @lodge = Lodge.find(params[:lodge_id])
    @room = @lodge.rooms.find(params[:room_id])
  end

  def seasonal_price_params
    params.require(:seasonal_price).permit(:name, :start_date, :end_date, :price)
  end
end