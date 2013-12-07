class UsersController < Clearance::UsersController
  before_action :set_user, only: [:update]
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'Configurações atualizadas com sucesso.' }
        format.json { head :no_content }
      else
        init_collections
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def user_from_params
    User.new(params.require(:user).permit(:email, :password, :name, :workload))
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end 
  
  def user_params
    params.require(:user).permit(:workload)
  end 
  
end