class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :country_code, :phone_number, :gender, :age_range, :ethnicity ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :country_code, :phone_number, :gender, :age_range, :ethnicity ])
  end

  private
  def check_approval
    if current_user && !current_user.approved?
      flash[:alert] =  "Your account is pending approval."
      redirect_to request.referer || root_path
    end
end
end
