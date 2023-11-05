class LodgeHousesController < ApplicationController
  skip_before_action :require_lodge, only: [:new, :create]

  def index
    @lodge_house = LodgeHouse.find_by(user_id: current_user.id)
  end

  def new
    @lodge_house = LodgeHouse.new
    @payment_methods = PaymentMethod.all
    @users = User.all
  end

  def create
    @lodge_house = LodgeHouse.new(lodgehouse_params)
    @lodge_house.user_id = current_user.id
    
    if @lodge_house.save
      current_user.lodge_house = @lodge_house
      return redirect_to @lodge_house, notice: 'Pousada cadastrada com sucesso!'
    end
    @payment_methods = PaymentMethod.all
    @users = User.all

    flash.now[:notice] = 'Não foi possível cadastrar a pousada!'
    render :new
  end

  def show
    @lodge_house = LodgeHouse.find(params[:id])
  end

  def edit
    @lodge_house = current_user.lodge_house
    @payment_methods = PaymentMethod.all
    @users = User.all
  end

  def update
    @lodge_house = LodgeHouse.find(params[:id])

    if @lodge_house.update(lodgehouse_params)
      return redirect_to @lodge_house, notice: 'Pousada editada com sucesso!'
    end

    flash.now[:notice] = 'Não foi possível editar a pousada!'
    render :edit
  end

  private

  def lodgehouse_params
    params.require(:lodge_house).permit(:brand_name, :corporate_name, :registration_number, :contact_number, :email, :full_address, :city, :state, :zip_code, :description, :payment_methods_id, :pets, :status, :terms_of_service, :check_in, :check_out)
  end
end
