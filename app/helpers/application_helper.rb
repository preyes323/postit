module ApplicationHelper
  def fix_url(str)
    if str.starts_with?('http://') || str.starts_with?('https://')
      str
    else
      "https://#{str}"
    end
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
