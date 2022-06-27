class UsersController < ApplicationController
    include UsersHelper
    
    def add_friends

        add_friend_list(params,current_user)
         
        respond_to do |format|     
            format.json { render json: {message: "success"} }
        end
    end 

    private
    def new_params
        params.permit(:friend_name,:friend_email,:friend_no)  
    end

end
