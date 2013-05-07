# encoding: utf-8 

class RegistrationsController < Devise::RegistrationsController
	def create
    	user = User.new(params[:user])
    	if user.save
      		render json: {user: 
                      {auth_token: user.authentication_token, 
      								email: user.email, 
      								first_name: user.first_name, 
      								phone_number: user.phone_number}}, status: 201
      		return
    	else
      		warden.custom_failure!
          user_errors = ""
          user.errors.each do |error|
            user_errors += " " +error.to_s
          end
          
      		render json:  {error: {message: user_errors}}, status: 422
    	end
	end	
end
