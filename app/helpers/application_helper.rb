module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def format_date(date)
    date.strftime("at %d/%m/%Y %H:%M")
  end
end
