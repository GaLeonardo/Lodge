class LodgeRoomsController < ApplicationController
  def new
    @lodge_room = LodgeRoom.new
  end

  def create
    @lodge_room = LodgeRoom.new(lodge_room_params)
    @service = Service.new(service_params)

    @lodge_room.lodge_house = current_user.lodge_house
    @service.lodge_room = @lodge_room

    if @lodge_room.save && @service.save
      return redirect_to @lodge_room, notice: 'Quarto cadastrado com sucesso.'
    end

    flash[:notice] = 'Não foi possível cadastrar o quarto.'

    render :new
  end

  def show
    @lodge_room = LodgeRoom.find(params[:id])
  end

  private

  def lodge_room_params
    params.require(:lodge_room).permit(:name, :description, :area, :number_people, :standard_price)
  end

  def service_params
    params.require(:lodge_room).permit(:bathroom, :balcony, :air_conditioner, :tv, :closet, :vault, :accessibility)
  end
end