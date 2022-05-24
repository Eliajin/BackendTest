class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
        p '#'*20
        p 'test'
        p params
        p '#'*20
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :address, :phonenumber])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname, :address, :phonenumber])
    end
  end