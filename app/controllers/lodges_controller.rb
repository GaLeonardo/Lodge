class LodgesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :city_list, :search]
  before_action :require_hosts_lodge, except: [:new, :create]
  before_action :user_is_host, except: [:show, :city_list, :search]

  def index
    @lodge = Lodge.find_by(user_id: current_user.id)
  end

  def new
    @lodge = Lodge.new
    @payment_method = @lodge.build_payment_method
  end

  def create
    @lodge = current_user.build_lodge(lodge_params)
    @payment_method = @lodge.build_payment_method(payment_method_params)
    @payment_method.valid?


    if @lodge.save
      return redirect_to @lodge, notice: 'Pousada cadastrada com sucesso.'
    end

    flash.now[:notice] = 'Não foi possível cadastrar a pousada.'

    render :new, status: :unprocessable_entity
  end

  def show
    @lodge = Lodge.find(params[:id])
    @rooms = @lodge.rooms
  end

  def edit
    @lodge = current_user.lodge
    @payment_methods = @lodge.payment_method
  end

  def update
    @lodge = Lodge.find(params[:id])

    if @lodge.update(lodge_params)
      return redirect_to @lodge, notice: 'Pousada editada com sucesso.'
    end

    flash.now[:notice] = 'Não foi possível editar a pousada.'
    render :edit
  end

  def city_list
    @lodges = Lodge.ativo.where(city: params[:city]).order(:brand_name)
  end

  def search
    if params[:search].blank?
      return redirect_to root_path, alert: 'A pesquisa não pode ser vazia'
    end

    @param = params[:search].downcase
    @lodges = Lodge.ativo.search(@param)
  end

  private

  def user_is_host
    unless current_user.host?
      redirect_to root_path, alert: 'Acesso não autorizado.'
    end
  end

  def lodge_params
    params.require(:lodge).permit(:brand_name, :corporate_name, :registration_number, :contact_number, :email, :full_address, :city, :state, :zip_code, :description, :pets, :status, :terms_of_service, :check_in, :check_out)
  end

  def payment_method_params
    params.require(:payment_method).permit(:bank_transfer, :credit_card, :debit_card, :cash, :deposit)
  end
end
