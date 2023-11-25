class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :personal_id, :role])
  end

  private

  def require_hosts_lodge
    if user_signed_in? && current_user.host? && current_user.lodge.nil?
      redirect_to new_lodge_path, alert: 'Para prosseguir, deve-se cadastrar uma pousada'
    end
  end
end
