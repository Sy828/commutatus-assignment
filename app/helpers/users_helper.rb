module UsersHelper

    def add_friend_list(params,current_user)
        exist_user=User.find_by_email(params[:friend_email])
        if exist_user.nil? 
            generated_password = 12345678
            exist_user=User.create!(email: params[:friend_email],name: params[:friend_name],mobile_number: params[:friend_no],password: generated_password)    
        end
        exist_user_conn=UserConnection.find_by(followable_id: current_user.id,follower_id: exist_user.id)
        if exist_user_conn.nil?
            UserConnection.create!(followable_id: current_user.id,follower_id: exist_user.id)
        end
    end    
end
