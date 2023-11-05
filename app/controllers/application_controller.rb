class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_lodge, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :registration_number, :role])
  end

  def require_lodge
    if current_user && current_user.Anfitrião?
      unless current_user.lodge_house
        redirect_to new_lodge_house_path
      end
    end
  end
end
