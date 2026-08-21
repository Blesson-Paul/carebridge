module ApplicationHelper
  def calculate_age(dob)
    return "Not set" unless dob
    today = Date.current
    age = today.year - dob.year
    age -= 1 if today < dob + age.years
    "#{age} yrs"
  end


def time_based_greeting
    hour = Time.current.hour
    case hour
    when 5..11
      "Good morning ☀️"
    when 12..16
      "Good afternoon 🌤️"
    when 17..21
      "Good evening 🌙"
    else
      "Welcome back ✨"
    end
  end
  def calculate_age(dob)
    return "Not set" unless dob
    today = Date.current
    age = today.year - dob.year
    age -= 1 if today < dob + age.years
    "#{age} yrs"
  end
  def days_since_diagnosed(date)
    return "Not added" unless date
    days = (Date.current - date).to_i
    if days == 0
      "Today"
    elsif days == 1
      "1 day ago"
    else
      "#{days} days ago"
    end
  end
end
