Spree::Admin::UsersController.class_eval do
  def switch_session
    session[:redirect_path] = request.referrer
    @imitated_to = Spree::User.find_by(id: params[:id])
    redirect_to root_url and return unless @imitated_to
    session[:imitated_by] = spree_current_user.email
    sign_out spree_current_user
    bypass_sign_in(@imitated_to)
    session[:imitating_user_email] = @imitated_to.email
    redirect_to root_url
  end
end
