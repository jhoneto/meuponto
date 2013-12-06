class UsersController < Clearance::UsersController
  
  def user_from_params
    User.new(params.require(:user).permit(:email, :password, :name))
  end
  
end