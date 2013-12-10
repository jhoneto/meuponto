class WorkingHoursController < ApplicationController
  before_action :set_working_hour, only: [:show, :edit, :update, :destroy]
  
  def index
    @working_hour = []
    if params[:data1] && params[:data2]
      @working_hour = WorkingHour.where("user_id = ? and day between ? and ?", current_user.id, params[:data1], params[:data2]).order("day DESC, record DESC") 
    end
  end
  
  def destroy
    @working_hour.destroy
    respond_to do |format|
      format.html { redirect_to working_hours_path }
      format.json { head :no_content }
    end
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
  
  def set_working_hour
    @working_hour = WorkingHour.find(params[:id])
  end
  
  def working_hour_params
    params.require(:working_hour).permit(:day, :record)
  end
end
