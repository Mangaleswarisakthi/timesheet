# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
   def passthru
	super
   end

  # GET|POST /users/auth/twitter/callback
  def failure
     super
   end

  # protected

  # The path used when OmniAuth fails
   def after_omniauth_failure_path_for(scope)
     super(scope)
   end
def github
	puts "request= #{request.url}"
   @user = User.from_omniauth(request.env["omniauth.auth"],cookies[:url])
    if @user  && cookies[:url]=="http://localhost:3000/users/sign_in"
      sign_in @user
      redirect_to root_path
    elsif cookies[:url]=="http://localhost:3000/users/sign_up"
	  redirect_to new_user_session_path, notice: 'Sign up Successfully.'
    else
      redirect_to new_user_session_path, notice: 'Please Signup First.'
    end
end
   def facebook
puts "request= #{request.url}"

   @user = User.from_omniauth(request.env["omniauth.auth"],cookies[:url])
    if @user  && cookies[:url]=="http://localhost:3000/users/sign_in"
      sign_in @user
      redirect_to root_path
    elsif cookies[:url]=="http://localhost:3000/users/sign_up"
	  redirect_to new_user_session_path, notice: 'Sign up Successfully.'
    else
      redirect_to new_user_session_path, notice: 'Please Signup First.'
    end
end
 def google_oauth2
@user = User.from_omniauth(request.env["omniauth.auth"],cookies[:url])
    if @user  && cookies[:url]=="http://localhost:3000/users/sign_in"
      sign_in @user
      redirect_to root_path
    elsif cookies[:url]=="http://localhost:3000/users/sign_up"
	  redirect_to new_user_session_path, notice: 'Sign up Successfully.'
    else
      redirect_to new_user_session_path, notice: 'Please Signup First.'
    end
end
end
