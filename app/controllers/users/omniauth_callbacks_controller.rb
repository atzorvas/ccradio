class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def wordpress_hosted
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Wordpress Hosted"
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.wordpress_hosted_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
