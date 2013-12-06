class WorkingHoursController < ApplicationController
  
  def index
    @working_hour = WorkingHour.where("user_id = ?", current_user.id).order("day DESC, record DESC")
  end
  
  def create
    @working_hour = WorkingHour.new(working_hour_params)
    @working_hour.user_id = current_user.id
    respond_to do |format|
      if @working_hour.save
        format.html { redirect_to root_path, notice: 'Registro salvo com sucesso.' }
        format.json { render action: 'show', status: :created, location: @working_hour }
      else
        format.html { render action: 'new' }
        format.json { render json: @working_hour.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def working_hour_params
    params.require(:working_hour).permit(:day, :record)
  end
end
