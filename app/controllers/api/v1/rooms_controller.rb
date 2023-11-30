class Api::V1::RoomsController < Api::V1::ApiController
  def index
    lodge = Lodge.find(params[:lodge_id])
    rooms = lodge.rooms

    render status: 200, json: rooms.as_json(except: [:created_at, :updated_at])
  end

  def pre_reservation
    room = Room.find(params[:id])
    reservation = room.reservations.build(reservation_params)

    if reservation.save
      render status: 200, json: reservation.as_json(except: [:user_id, :created_at, :updated_at, :status, :room_id])
    else
      render status: 200, json: { errors: reservation.errors.full_messages }
    end
  end

  private

  def reservation_params
    params.permit(:start_date, :end_date, :number_guests)
  end
end