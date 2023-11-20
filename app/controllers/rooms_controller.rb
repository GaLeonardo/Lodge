class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_lodge, only: [:show, :create, :edit, :update]
  before_action :set_room_and_service, only: [:show, :edit, :update]
  before_action :host_owns_lodge, only: [:create, :edit, :update]

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
      return redirect_to [@lodge, @room], notice: 'Quarto cadastrado com sucesso.'
    end

    flash.now[:notice] = 'Não foi possível cadastrar o quarto.'

    render :new
  end

  def edit
    @lodge = Lodge.find(params[:lodge_id])
    @room = @lodge.rooms.find(params[:id])
  end

  def update
    @service.update(service_params)
    if @room.update(room_params)
      return redirect_to [@lodge, @room], notice: 'Quarto atualizado com sucesso.'
    end

    flash.now[:notice] = 'Não foi possível atualizar o quarto.'
    render 'edit', status: :unprocessable_entity
  end

  def show
    @room = Room.find(params[:id])
    @seasonal_prices = @room.seasonal_prices
  end

  private

  def set_lodge
    @lodge = Lodge.find(params[:lodge_id])

    if @lodge.nil?
      redirect_to root_path, alert: 'Essa página não existe'
    end
  end

  def set_room_and_service
    @room = @lodge.rooms.find(params[:id])

    if @room.nil?
      redirect_to root_path, alert: 'Essa página não existe'
    end
    @service = @room.service
  end

  def host_owns_lodge
    unless current_user.host? && current_user == @lodge.user
      redirect_to root_path, alert: 'Acesso não autorizado.'
    end
  end

  def room_params
    params.require(:room).permit(:name, :description, :area, :max_capacity, :standard_price)
  end

  def service_params
    params.require(:room).permit(:has_bathroom, :has_balcony, :has_air_conditioner, :has_tv, :has_closet, :has_vault, :is_accessible)
  end
end