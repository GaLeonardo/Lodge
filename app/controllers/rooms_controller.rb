class RoomsController < ApplicationController
  def new
    @room = LodgeRoom.new
  end

  def create
    @room = LodgeRoom.new(room_params)
    @service = Service.new(service_params)

    @room.lodge = current_user.lodge
    @service.room = @room

    if @room.save && @service.save
      return redirect_to @room, notice: 'Quarto cadastrado com sucesso.'
    end

    flash[:notice] = 'Não foi possível cadastrar o quarto.'

    render :new
  end

  def show
    @room = LodgeRoom.find(params[:id])
    @seasonal_prices = @room.seasonal_prices 
    p @seasonal_prices
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :area, :number_people, :standard_price)
  end

  def service_params
    params.require(:room).permit(:bathroom, :balcony, :air_conditioner, :tv, :closet, :vault, :accessibility)
  end
end