class DailySummary < ActiveRecord::Base
  belongs_to :user
  
  def self.update_summary(user, day, value)
    
    summary = DailySummary.where("user_id = ? and day = ?", user.id, day).first
    summary = DailySummary.new if summary.nil?
    
    summary.user_id = user.id
    summary.day = day
    summary.value = value
    summary.description = "----------------------"
    summary.save
  end
  
  def self.current_value(user)
    DailySummary.where("user_id = ?", user.id).sum("value")
  end
end
