class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?


  def destroy
    super do |resource|
      sign_out(resource_name) # Ensure the user is signed out
      redirect_to new_user_registration_path and return # Redirect to sign-up page
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :avatar, profile_attributes: [:name, :bio, :phone_number, :age]])
  end
end
