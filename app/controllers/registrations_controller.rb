class RegistrationsController < Devise::RegistrationsController
    # POST /resource
    def create
        build_resource(sign_up_params)

        resource.save
        yield resource if block_given?
        if resource.persisted?
            if resource.active_for_authentication?
                set_flash_message! :notice, :signed_up
                sign_up(resource_name, resource)
                respond_with resource, location: after_sign_up_path_for(resource)
            else
                set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
                expire_data_after_sign_in!
                respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
        else
            clean_up_passwords resource
            set_minimum_password_length
            redirect_to(request.referrer, alert:resource.errors.full_messages[0])
        end
    end

    protected

    def after_sign_up_path_for(resource)
        if current_user.is_manager?
            #print ("\n\n\n\n manager \n\n\n\n\n")
            '/make_department' # Or :prefix_to_your_route
        elsif current_user.is_admin?
            #print ("\n\n\n\n non manager \n\n\n\n")
            '/home'
        elsif current_user.is_user?
            '/home'
        else
            '/home'
        end
    end
end