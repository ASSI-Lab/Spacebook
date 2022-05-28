class RegistrationsController < Devise::RegistrationsController
    protected
  
    def after_sign_up_path_for(resource)
        if current_user.is_manager?
            #print ("\n\n\n\n manager \n\n\n\n\n")
            '/make_department' # Or :prefix_to_your_route
        else
            #print ("\n\n\n\n non manager \n\n\n\n")
            '/home'
        end
        
    end
  end