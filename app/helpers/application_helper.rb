module ApplicationHelper
  def calculate_age(dob)
    return "Not set" unless dob
    now = Date.current
    age = now.year - dob.year - (now.strftime('%m%d') < dob.strftime('%m%d') ? 1 : 0)
    "#{age} yrs"
  end
end
