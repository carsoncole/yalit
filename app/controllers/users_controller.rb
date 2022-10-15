class UsersController < Clearance::UsersController

  def new
    @user = User.new
    @user.email = params[:email] if params[:email]
  end
end
