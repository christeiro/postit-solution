module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def format_date(date)
  	if logged_in? && !current_user.timezone.blank?
  		date = date.in_time_zone(current_user.timezone)
  	end
    date.strftime("at %d/%m/%Y %H:%M %Z")
  end
end
