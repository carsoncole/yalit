class UsersController < Clearance::UsersController

  def new
    @user = User.new
    @user.email = params[:email] if params[:email]
    flash[:notice] = "Sign-ups are open to Martech domains. Please contact carson@grade.us if you have any questions or sign-up issues."
  end

  def create
    super
    flash[:notice] = "Sign-ups are open to Martech domains. Please contact carson@grade.us if you have any questions or sign-up issues."
  end
end
