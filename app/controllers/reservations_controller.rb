class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:confirm]
  before_action :get_lodge_and_room, except: [:confirmate, :confirm]

  def new
    @reservation = @room.reservations.build
  end

  def confirmate
    @reservation = Reservation.find(params[:id])
    @lodge = @reservation.room.lodge
  end

  def create
    @reservation = @room.reservations.build(reservation_params)

    if @reservation.save
      return redirect_to confirmate_reservation_path(@reservation)
    end

    flash.now[:notice] = "Não foi possível realizar a reserva"
    render 'new'
  end

  def confirm

  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :number_guests)
  end

  def pre_reservation_params
    params.permit(:start_date, :end_date, :number_guests)
  end

  def get_lodge_and_room
    @lodge = Lodge.find(params[:lodge_id])
    @room = @lodge.rooms.find(params[:room_id])
  end
end