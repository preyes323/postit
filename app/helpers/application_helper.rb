module ApplicationHelper
  def fix_url(str)
    if str.starts_with?('http://') || str.starts_with?('https://')
      str
    else
      "https://#{str}"
    end
  end

  def display_datetime(dt)
    dt = dt.in_time_zone(current_user.time_zone) if logged_in? && !current_user.time_zone.blank?
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
