module ApplicationHelper
  def calculate_age(dob)
    return "Not set" unless dob
    today = Date.current
    age = today.year - dob.year
    age -= 1 if today < dob + age.years
    "#{age} yrs"
  end
end
