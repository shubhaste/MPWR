class RegistrationsController < Devise::RegistrationsController
   before_filter :check_permissions, :only => [:new, :create]
   skip_before_filter :require_no_authentication
 

  def check_permissions
    authorize! :create, resource
  end

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        #sign_up(resource_name, resource)
        #respond_with resource, location: after_sign_up_path_for(resource)
        respond_with resource, location: user_registration_path
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        #respond_with resource, location: after_inactive_sign_up_path_for(resource)
        respond_with resource, location: user_registration_path
      end
    else
      clean_up_passwords resource
      #set_minimum_password_length
      respond_with resource
    end
  end

  protected
   def after_sign_up_path_for(resource)
      signed_in_root_path(resource)
    end
end 
