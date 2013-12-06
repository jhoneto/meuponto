class HomeController < ApplicationController
  def index
    @working_hour = WorkingHour.new
    @today = WorkingHour.where("day = ? and user_id = ?", Date.today, current_user.id).order("record")
    @today_total = WorkingHour.today_total(current_user)
    @balance = WorkingHour.balance(current_user)
  end
end
