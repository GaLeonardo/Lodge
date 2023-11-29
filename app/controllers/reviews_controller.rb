class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_reservation, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = @reservation.build_review(review_params)
    @lodge = @reservation.room.lodge

    if @review.save
      return redirect_to @lodge, notice: 'Comentário realizado com sucesso.'
    end
  end

  private
  
  def review_params
    params.require(:review).permit(:commentary, :rating)
  end

  def get_reservation
    @reservation = Reservation.find(params[:reservation_id])
  end
end