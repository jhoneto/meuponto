class WorkingHour < ActiveRecord::Base
  
  def self.balance(user)
    days = WorkingHour.where("user_id = ?", user.id).distinct.select("day")
    balance = 0
    days.each do |d|
      balance += self.calculate_hours(d.day, user) - user.workload.to_f
    end
    balance
  end
  
  def self.today_total(user)
    self.calculate_hours(Date.today, user) 
  end
  
  private
  
  def self.calculate_hours(day, user)
    records = WorkingHour.where("day = ? and user_id = ?", day, user.id).order("record")
    total = 0
    size = records.size / 2 - 1
    for i in 0..size
      total += records[i*2 + 1].record - records[i*2].record
    end
    total/60/60
  end
end
