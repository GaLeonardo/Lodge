class SeasonalPricessController < ApplicationController
  def new
    @seasonal_price = SeasonalPrice.new
  end

  def create
    p params
    @seasonal_price = SeasonalPrice.new(seasonal_price_params)
    @seasonal_price.room = current_user.lodge.rooms.find(params[:room_id])

    if @seasonal_price.save
      return redirect_to @seasonal_price.room, notice: 'Valor por período adicionado com sucesso.'
    end

    flash[:notice] = 'Não foi possível adicionar valor por periodo.'

    render :new
  end

  private

  def seasonal_price_params
    params.require(:seasonal_price).permit(:name, :start_date, :end_date, :value)
  end
end