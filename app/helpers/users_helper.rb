module UsersHelper

	def signup_error_message(user)
		 if user.errors.any? 
       user.errors.full_messages.each do |error| 
        
           error
        
       end 
     end 
  end 
end
