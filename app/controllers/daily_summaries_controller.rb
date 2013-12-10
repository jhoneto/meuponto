class DailySummariesController < ApplicationController
  
  def index
    @new_daily_summary = DailySummary.new
    @daily_summary = []
    if params[:data1] && params[:data2]
      @daily_summary = DailySummary.where("user_id = ? and day between ? and ?", current_user.id, params[:data1], params[:data2]).order("day ASC")
    end
  end
  
  def create
    @daily_summary = DailySummary.new(daily_summary_params)
    @daily_summary.user_id = current_user.id
    @daily_summary.manually = true
    respond_to do |format|
      if @daily_summary.save
        format.html { redirect_to daily_summaries_path, notice: 'Registro salvo com sucesso.' }
        format.json { render action: 'show', status: :created, location: @daily_summary }
      else
        format.html { render action: 'new' }
        format.json { render json: @daily_summary.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @daily_summary.destroy
    respond_to do |format|
      format.html { redirect_to dailty_summary_index_path }
      format.json { head :no_content }
    end
  end
  
  
  private
  
  def daily_summary_params
    params.require(:daily_summary).permit(:description, :day, :value)
  end
  
  
end
