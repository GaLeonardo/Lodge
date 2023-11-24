class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:confirm, :show, :my_reservations, :cancel]
  before_action :get_lodge_and_room, except: [:confirmate, :confirm, :show, :my_reservations, :cancel, :check_in]
  before_action :get_reservation, only: [:confirmate, :confirm, :cancel, :check_in]

  def new
    @reservation = @room.reservations.build
  end

  def confirmate
    @lodge = @reservation.room.lodge
  end

  def create
    @reservation = @room.reservations.build(reservation_params)

    if @reservation.save
      return redirect_to confirmate_reservation_path(@reservation)
    end

    flash.now[:notice] = "Não foi possível realizar a reserva."
    render 'new'
  end

  def confirm
    if @reservation.update(status: 1, user: current_user)
      redirect_to @reservation, notice: 'Quarto reservado com sucesso.'
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
    @lodge = @room.lodge
  end

  def my_reservations
    @user = current_user
    @reservations = @user.reservations
  end

  def cancel
    if @reservation.cancel_unless_less_than_seven_days
      @reservation.canceled!
      return redirect_to my_reservations_path, notice: 'Reserva cancelada com sucesso.'
    end
    
    redirect_to my_reservations_path, notice: 'Não é possível cancelar reservar com menos de 7 dias para o check-in.'
  end

  def check_in
    if @reservation.start_date <= Date.today
      @reservation.check_in
      return redirect_to lodge_reservations_path, notice: 'Check-in realizado com sucesso.'
    end  
    
    return redirect_to lodge_reservations_path, notice: 'Não foi possível realizar o check-in.'
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

  def get_reservation
    @reservation = Reservation.find(params[:id])
  end
end