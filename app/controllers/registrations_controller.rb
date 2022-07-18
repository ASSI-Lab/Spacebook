class RegistrationsController < Devise::RegistrationsController

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