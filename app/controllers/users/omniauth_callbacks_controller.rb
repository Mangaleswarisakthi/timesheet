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
	c=$sign
   @user = User.from_omniauth(request.env["omniauth.auth"],c)
    if @user && c==2
      sign_in @user
      redirect_to root_path
elsif c==1
	  redirect_to new_user_session_path, notice: 'Sign up Successfully.'
    else
      redirect_to new_user_session_path, notice: 'Please Signup First.'
    end	
  end
   def facebook
puts "request= #{request.url}"
c=$sign
   @user = User.from_omniauth(request.env["omniauth.auth"],c)
    if @user && c==2
      sign_in @user

      redirect_to root_path
elsif c==1

	  redirect_to new_user_session_path, notice: 'Sign up Successfully.'
    else
      redirect_to new_user_session_path, notice: 'Please Signup First.'
    end
end
 def google_oauth2
c=$sign
    @user = User.from_omniauth(request.env["omniauth.auth"],c)
    if @user  && c==2
      sign_in @user
      redirect_to root_path
elsif c==1
	  redirect_to new_user_session_path, notice: 'Sign up Successfully.'
    else
      redirect_to new_user_session_path, notice: 'Please Signup First.'
    end
end
end
