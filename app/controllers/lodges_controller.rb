class LodgesController < ApplicationController
  skip_before_action :require_lodge, only: [:new, :create]
  before_action :set_room_id, only: [:show]

  def index
    @lodge = Lodge.find_by(user_id: current_user.id)
  end

  def new
    @lodge = Lodge.new
    @payment_methods = @lodge.build_payment_method
    @users = User.all
  end

  def create
    @lodge = Lodge.new(lodgehouse_params)
    @lodge.user_id = current_user.id
    
    if @lodge.save
      current_user.lodge = @lodge
      return redirect_to @lodge, notice: 'Pousada cadastrada com sucesso!'
    end
    @payment_methods = PaymentMethod.all
    @users = User.all

    flash.now[:notice] = 'Não foi possível cadastrar a pousada!'
    render :new
  end

  def show
    @lodge = Lodge.find(params[:id])
    @rooms = @lodge.rooms
  end

  def edit
    @lodge = current_user.lodge
    @payment_methods = PaymentMethod.all
    @users = User.all
  end

  def update
    @lodge = Lodge.find(params[:id])

    if @lodge.update(lodgehouse_params)
      return redirect_to @lodge, notice: 'Pousada editada com sucesso!'
    end

    flash.now[:notice] = 'Não foi possível editar a pousada!'
    render :edit
  end

  private

  def lodgehouse_params
    params.require(:lodge).permit(:brand_name, :corporate_name, :registration_number, :contact_number, :email, :full_address, :city, :state, :zip_code, :description, :pets, :status, :terms_of_service, :check_in, :check_out)
  end

  def set_room_id
    @room_id = current_user.lodge.rooms.find(params[:id])
  end
end
