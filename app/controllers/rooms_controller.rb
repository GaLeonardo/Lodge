class RoomsController < ApplicationController
  def new
    @lodge = current_user.lodge
    @room = @lodge.rooms.build
    @service = @room.build_service
  end

  def create
    @lodge = current_user.lodge
    @room = @lodge.rooms.build(room_params)
    @service = @room.build_service(service_params)

    if @room.save
      return redirect_to @room, notice: 'Quarto cadastrado com sucesso.'
    end

    flash[:notice] = 'Não foi possível cadastrar o quarto.'

    render :new
  end

  def show
    @room = Room.find(params[:id])
    @seasonal_prices = @room.seasonal_prices 
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :area, :max_people, :standard_price)
  end

  def service_params
    params.require(:room).permit(:has_bathroom, :has_balcony, :has_air_conditioner, :has_tv, :has_closet, :has_vault, :is_accessible)
  end
end