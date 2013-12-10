module ApplicationHelper
  def hour_to_human(hours)
    h = hours.to_i
    mm = (((hours - h).round(2)*60)/100).round(2)*100
    mm = mm*(-1) if mm < 0
    mm = mm.to_i.to_s
    mm = "0" + mm if mm.length < 2
    return "#{h}:#{mm}"
  end
end
